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

  describe "#any_winning_line" do
    context "when there is no winning line adjacent to the given coordinates" do
      subject(:board_no_win) { described_class.new(Array.new(Board::WIDTH) { empty_column }) }

      before do
        empty_cells = ["(  )", "(  )", "(  )", "(  )", "(  )", "(  )"]
        allow(empty_column).to receive(:cells).and_return(empty_cells)
      end

      it "returns false" do
        result = board_no_win.any_winning_line?("🔴", [0, 0])
        expect(result).to be(false)
      end
    end

    context "when there is a winning line adjacent to the given coordinates" do
      subject(:board_win) { described_class.new(Array.new(Board::WIDTH - 1) { empty_column }.unshift(full_column)) }

      before do
        win_cells = ["(🔴)", "(🔴)", "(🔴)", "(🔴)", "(  )", "(  )"]
        allow(full_column).to receive(:cells).and_return(win_cells)
      end

      it "returns true" do
        result = board_win.any_winning_line?("🔴", [0, 0])
        expect(result).to be(true)
      end
    end
  end
end
