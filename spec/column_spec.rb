require_relative "../lib/column"

describe Column do
  describe "#full?" do
    context "when the column is empty" do
      subject(:column_empty) { described_class.new }

      it "returns false" do
        result = column_empty.full?
        expect(result).to be(false)
      end
    end

    context "when the column is between empty and full" do
      five_cells = ["(🔵)", "(🔵)", "(🔴)", "(🔴)", "(🔴)", "(  )"]
      subject(:column_not_full) { described_class.new(five_cells) }

      it "returns false" do
        result = column_not_full.full?
        expect(result).to be(false)
      end
    end

    context "when the column is full" do
      six_cells = ["(🔵)", "(🔵)", "(🔴)", "(🔴)", "(🔴)", "(🔴)"]
      subject(:column_full) { described_class.new(six_cells) }

      it "returns true" do
        result = column_full.full?
        expect(result).to be(true)
      end
    end
  end

  describe "#drop_token" do
    let(:token) { "🔴" }

    context "when the cells are full" do
      six_cells = ["(🔵)", "(🔵)", "(🔴)", "(🔴)", "(🔴)", "(🔴)"]
      subject(:column_unavailable) { described_class.new(six_cells) }

      it "does not change the cells" do
        column_unavailable.drop_token(token)
        result = column_unavailable.cells
        expect(result).to eq(six_cells)
      end
    end

    context "when there is at least one cell available" do
      five_cells = ["(🔵)", "(🔵)", "(🔴)", "(🔴)", "(🔴)", "(  )"]
      subject(:column_available) { described_class.new(five_cells) }

      it "drops a token into the next available cell" do
        updated_cells = ["(🔵)", "(🔵)", "(🔴)", "(🔴)", "(🔴)", "(🔴)"]
        column_available.drop_token(token)
        result = column_available.cells
        expect(result).to eq(updated_cells)
      end
    end
  end
end
