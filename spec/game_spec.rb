require_relative "../lib/game"

describe Game do
  subject(:game) { described_class.new(board, first_player, second_player) }

  let(:board) { double("board") }
  let(:first_player) { double("player1") }
  let(:second_player) { double("player2") }

  describe "#active_player" do
    before do
      allow(first_player).to receive(:active).and_return(false)
      allow(second_player).to receive(:active).and_return(true)
    end

    it "returns the active player" do
      result = game.active_player
      expect(result).to be(second_player)
    end
  end

  describe "#idle_player" do
    before do
      allow(first_player).to receive(:active).and_return(false)
      allow(second_player).to receive(:active).and_return(true)
    end

    it "returns the idle player" do
      result = game.idle_player
      expect(result).to be(first_player)
    end
  end

  describe "#select_random_player" do
    it "returns either player1 or player2 at random" do
      result = game.select_random_player
      expect(result).to be(first_player).or be(second_player)
    end
  end

  # This method is impossible to test without stubbing the SUT.
  describe "#activate_first_mover" do
    # rubocop:disable RSpec/SubjectStub
    before { allow(game).to receive(:select_random_player).and_return(first_player) }
    # rubocop:enable all

    it "sends the activate message to the randomly selected player" do
      allow(first_player).to receive(:activate)
      game.activate_first_mover
      expect(first_player).to have_received(:activate)
    end
  end

  describe "#switch_active_player" do
    context "when player1 is active and player2 is idle" do
      before do
        allow(first_player).to receive(:active).and_return(true)
        allow(first_player).to receive(:deactivate)
        allow(second_player).to receive(:active).and_return(false)
        allow(second_player).to receive(:activate)
      end

      it "sends the deactivate message to player1" do
        game.switch_active_player
        expect(first_player).to have_received(:deactivate)
      end

      it "sends the activate message to player2" do
        game.switch_active_player
        expect(second_player).to have_received(:activate)
      end
    end
  end

  describe "#valid_player_input?" do
    let(:valid_index) { Board::WIDTH - 1 }

    context "when given index is out of range based on board width" do
      it "returns false" do
        index_out_of_range = Board::WIDTH + 1
        result = game.valid_player_input?(index_out_of_range)
        expect(result).to be(false)
      end
    end

    context "when given index is within valid range but column at index is unavailable" do
      before do
        allow(board).to receive(:column_available?).with(valid_index).and_return(false)
      end

      it "returns false" do
        result = game.valid_player_input?(valid_index)
        expect(result).to be(false)
      end
    end

    context "when given index is within valid range and column at index is available" do
      before do
        allow(board).to receive(:column_available?).with(valid_index).and_return(true)
      end

      it "returns true" do
        result = game.valid_player_input?(valid_index)
        expect(result).to be(true)
      end
    end
  end

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  describe "#player_input" do
    let(:error_msg) { "Invalid input. Please try again: " }
    let(:valid_input) { Board::WIDTH }
    let(:invalid_input) { Board::WIDTH + 1 }

    before do
      allow(first_player).to receive(:active).and_return(true)
      allow(second_player).to receive(:active).and_return(false)
      allow(board).to receive(:column_available?).with(valid_input - 1).and_return(true)
      allow(board).to receive(:column_available?).with(invalid_input - 1).and_return(false)
      allow($stdout).to receive(:print)
    end

    context "when the player submits a valid input" do
      before do
        allow(first_player).to receive(:choose_column).and_return(valid_input)
      end

      it "ends the loop and does not display the error message" do
        expect { game.player_input }.not_to output(error_msg).to_stdout
      end
    end

    context "when the player submits an invalid input, then a valid input" do
      before do
        allow(first_player).to receive(:choose_column).and_return(invalid_input, valid_input)
      end

      it "displays the errors message once, then ends the loop" do
        expect { game.player_input }.to output(error_msg).to_stdout
      end
    end
  end
  # rubocop:enable all
end
