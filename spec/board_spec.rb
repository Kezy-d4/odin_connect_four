require_relative "../lib/board"

describe Board do
  let(:empty_column) { double("empty_column") }
  let(:full_column) { double("full_column") }
  let(:columns) { Array.new(Board::WIDTH - 1) { full_column } << empty_column }

  describe "#full?" do
    context "when the board is empty" do
      subject(:board_empty) { described_class.new(Array.new(Board::WIDTH) { empty_column }) }

      before { allow(empty_column).to receive(:full?).and_return(false) }

      it "returns false" do
        result = board_empty.full?
        expect(result).to be(false)
      end
    end

    context "when the board is between empty and full" do
      subject(:board_mid) { described_class.new(columns) }

      before do
        allow(empty_column).to receive(:full?).and_return(false)
        allow(full_column).to receive(:full?).and_return(true)
      end

      it "returns false" do
        result = board_mid.full?
        expect(result).to be(false)
      end
    end

    context "when the board is full" do
      subject(:board_full) { described_class.new(Array.new(Board::WIDTH) { full_column }) }

      before { allow(full_column).to receive(:full?).and_return(true) }

      it "returns true" do
        result = board_full.full?
        expect(result).to be(true)
      end
    end
  end

  describe "#drop_token_in_column" do
    subject(:board) { described_class.new(columns) }

    let(:token) { "🔴" }

    it "sends the drop token message to the given column with the given token" do
      column_index = 6
      allow(empty_column).to receive(:drop_token).with(token)
      board.drop_token_in_column(column_index, token)
      expect(empty_column).to have_received(:drop_token).with(token)
    end
  end

  describe "#column_available?" do
    context "when the column at the given index is available" do
      subject(:board_available) { described_class.new(columns) }

      before { allow(empty_column).to receive(:full?).and_return(false) }

      it "returns true" do
        column_index = 6
        result = board_available.column_available?(column_index)
        expect(result).to be(true)
      end
    end

    context "when the column at the given index is full" do
      subject(:board_unavailable) { described_class.new(columns) }

      before { allow(full_column).to receive(:full?).and_return(true) }

      it "returns false" do
        column_index = 0
        result = board_unavailable.column_available?(column_index)
        expect(result).to be(false)
      end
    end
  end

  describe "#most_recent_token_coordinates" do
    subject(:board_coordinates) { described_class.new(columns) }

    context "when the given column is empty" do
      before do
        allow(empty_column).to receive_messages(most_recent_token_index: nil, empty?: true)
      end

      it "returns nil" do
        column_index = Board::WIDTH - 1
        result = board_coordinates.most_recent_token_coordinates(column_index)
        expect(result).to be_nil
      end
    end

    context "when the given column is not empty" do
      before do
        allow(full_column).to receive_messages(most_recent_token_index: 5, empty?: false)
      end

      it "returns the correct x and y coordinates of the most recent token in that column" do
        column_index = 0
        result = board_coordinates.most_recent_token_coordinates(column_index)
        expected_x_coordinate = column_index
        expected_y_coordinate = 5
        expect(result).to eq([expected_x_coordinate, expected_y_coordinate])
      end
    end
  end

  # rubocop:disable all RSpec/MultipleMemoizedHelpers
  describe "#any_winning_line?" do 
    let(:red_cells) { ["(🔴)", "(🔴)", "(🔴)", "(🔴)", "(🔴)", "(🔴)"] }
    let(:blue_cells) { ["(🔵)", "(🔵)", "(🔵)", "(🔵)", "(🔵)", "(🔵)"] }
    let(:empty_cells) { ["(  )", "(  )", "(  )", "(  )", "(  )", "(  )"] }

    context "when there is a winning line on the board for the red token" do
      subject(:board_red_winner) { described_class.new(columns) }

      before { allow(full_column).to receive(:cells).and_return(red_cells) }

      it "returns true" do
        result = board_red_winner.any_winning_line?("🔴")
        expect(result).to be(true)
      end
    end

    context "when there is a winning line on the board for the blue token" do
      subject(:board_blue_winner) { described_class.new(columns) }

      before { allow(full_column).to receive(:cells).and_return(blue_cells) }

      it "returns true" do
        result = board_blue_winner.any_winning_line?("🔵")
        expect(result).to be(true)
      end
    end

    context "when there is no winning line for the given token" do
      subject(:board_no_winner) { described_class.new(Array.new(Board::WIDTH) { empty_column }) }

      before { allow(empty_column).to receive(:cells).and_return(empty_cells) }

      it "returns false" do
        result = board_no_winner.any_winning_line?("🔵")
        expect(result).to be(false)
      end
    end
  end
  # rubocop:enable all

  describe "#generate_all_cell_coordinates" do
    subject(:board_all_coordinates) { described_class.new(columns) }

    it "returns an array with a length of 42" do
      result = board_all_coordinates.generate_all_cell_coordinates.length
      expect(result).to eq(42)
    end

    it "the first element of the array is [0, 0]" do
      result = board_all_coordinates.generate_all_cell_coordinates.first
      expect(result).to eq([0, 0])
    end

    it "the last element of the array is [6, 5]" do
      result = board_all_coordinates.generate_all_cell_coordinates.last
      expect(result).to eq([6, 5])
    end
  end
end
