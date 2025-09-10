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

    let(:column_index) { 6 }
    let(:token) { "🔴" }

    it "sends the drop token message to the given column with the given token" do
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
end
