# spec/models/user_spec.rb
require 'sinatra/activerecord'
require_relative '../../models/init.rb'


describe User do
  it "is valid with a username an email and a password" do
    user = User.new(username: "Martincito28", email: "martinp@example.com", password_digest: "password")
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = User.new(email: "roman10@example.com", password_digest: "password")
    expect(user).not_to be_valid
  end

  it "is invalid without an email address" do
    user = User.new(username: "RR10", password_digest: "password")
    expect(user).not_to be_valid
  end

  it "is invalid without an password" do
    user = User.new(username: "RR10", email: "roman10@gmail.com")
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate email address" do
    existing_user = User.create(username: "Messi10", email: "messi@example.com", password_digest: "password")
    user = User.new(username: "argento", email: "messi@example.com", password_digest: "password")
    expect(user).not_to be_valid
    existing_user.destroy
  end

  it "is invalid with a duplicate username" do
    existing_user = User.create(username: "Marcos10", email: "marcos@example.com", password_digest: "password")
    user = User.new(username: "Marcos10", email: "otromail@example.com", password_digest: "password")
    expect(user).not_to be_valid
    existing_user.destroy
  end

  describe "username_taken?" do
    it 'returns true if username is taken' do
      #aca está hardcodeado, mejorar después
      existing_user = User.create(username: "Marcos10", email: "marcos@example.com", password_digest: "password")
      result = User.username_taken?("Marcos10")
      expect(result).to be true
      existing_user.destroy
    end

    it 'returns false if username is not taken' do
      result = User.username_taken?('non_existing_username')
      expect(result).to be false
    end
  end

  describe "email_taken?" do
    it 'returns true if email is taken' do
      existing_user = User.create(username: "Messi10", email: "messi@example.com", password_digest: "password")
      result = User.email_taken?('messi@example.com')
      expect(result).to be true
      existing_user.destroy
    end

    it 'returns false if username is not taken' do
      result = User.username_taken?('non_existing_email')
      expect(result).to be false
    end
  end

  describe 'passwords_match?' do
    it 'returns true if passwords match' do
      result = User.passwords_match?('password123', 'password123')
      expect(result).to be true
    end

    it 'returns false if passwords do not match' do
      result = User.passwords_match?('password123', 'different_password')
      expect(result).to be false
    end

    it 'returns false if password is empty' do
      result = User.passwords_match?('', 'password123')
      expect(result).to be false
    end

    it 'returns false if confirm_password is empty' do
      result = User.passwords_match?('password123', '')
      expect(result).to be false
    end

    it 'returns false if both password and confirm_password are empty' do
      result = User.passwords_match?('', '')
      expect(result).to be false
    end

  end

  describe 'initialize_knowledges' do
    it 'initializes knowledges and sets points to 0' do
      # Crea un usuario de prueba
      user = User.create(username: "user_test", email: "user@test.com", password_digest: "password")
      topic = Topic.create(name: "Historia", amount_questions_L1: 3, amount_questions_L2: 3, amount_questions_L3: 3)

      # Llama al método que estás probando
      user.initialize_knowledges

      # Verifica que los conocimientos se hayan creado correctamente
      topics = Topic.all
      topics.each do |topic|
        knowledge = Knowledge.find_by(user: user, topic: topic)
        expect(knowledge).not_to be_nil
        expect(knowledge.level).to eq(1)
        expect(knowledge.correct_answers_count).to eq(0)
      end

      # Verifica que el atributo points se haya establecido en 0
      expect(user.points).to eq(0)
      Knowledge.destroy_all
      topic.destroy
      user.destroy
    end
  end

  describe 'update_points' do
    it 'increases points when answer is correct' do
      user = User.create(username: 'test_user1', email: 'test1@example.com', password: 'password123')
      initial_points = user.points

      user.update_points(true, 3, 42)

      expect(user.points).to eq(initial_points + 30 + user.streak + 42) # 10 * level (3) = 30, 42 seconds from bonus time

      user.destroy
    end

    it 'decreases points when answer is incorrect' do
      user = User.create(username: 'test_user2', email: 'test2@example.com', password: 'password123')
      initial_points = 10000
      user.points = initial_points

      user.update_streak(false)
      user.update_points(false, 2, 42)

      expect(user.points).to eq(initial_points - 51) # -4 * 2 - 1 - 42 = 51

      user.destroy
    end
  end

  describe '#update_streak' do
    context 'when correct is true' do
      it 'increases the streak to 1 if streak is 0' do
        user = User.new(streak: 0)
        user.update_streak(true)
        expect(user.streak).to eq(1)
      end

      it 'increases the streak at 1 if streak is greater than 0' do
        user = User.new(streak: 2)
        user.update_streak(true)
        expect(user.streak).to eq(3)
      end

      it 'set the streak at 1 if streak is less than 0' do
        user = User.new(streak: -4)
        user.update_streak(true)
        expect(user.streak).to eq(1)
      end
    end

    context 'when correct is false' do
      it 'decreases the streak to -1 if streak is 0' do
        user = User.new(streak: 0)
        user.update_streak(false)
        expect(user.streak).to eq(-1)
      end

      it 'decreases the streak at 1 if streak is less than 0' do
        user = User.new(streak: -5)
        user.update_streak(false)
        expect(user.streak).to eq(-6)
      end

      it 'set the streak at -1 if streak is greater than 0' do
        user = User.new(streak: 5)
        user.update_streak(false)
        expect(user.streak).to eq(-1)
      end
    end
  end
end