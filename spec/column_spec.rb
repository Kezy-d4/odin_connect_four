require_relative "../lib/column"

describe Column do
  let(:five_cells) { ["(🔵)", "(🔵)", "(🔴)", "(🔴)", "(🔴)", "(  )"] }
  let(:six_cells) { ["(🔵)", "(🔵)", "(🔴)", "(🔴)", "(🔴)", "(🔴)"] }

  describe "#full?" do
    context "when the column is empty" do
      subject(:column_empty) { described_class.new }

      it "returns false" do
        result = column_empty.full?
        expect(result).to be(false)
      end
    end

    context "when the column is between empty and full" do
      subject(:column_not_full) { described_class.new(five_cells) }

      it "returns false" do
        result = column_not_full.full?
        expect(result).to be(false)
      end
    end

    context "when the column is full" do
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
      subject(:column_unavailable) { described_class.new(six_cells) }

      it "does not change the cells" do
        column_unavailable.drop_token(token)
        result = column_unavailable.cells
        expect(result).to eq(six_cells)
      end
    end

    context "when there is at least one cell available" do
      subject(:column_available) { described_class.new(five_cells) }

      it "drops a token into the next available cell" do
        updated_cells = six_cells
        column_available.drop_token(token)
        result = column_available.cells
        expect(result).to eq(updated_cells)
      end
    end
  end

  describe "#empty?" do
    context "when the column is empty" do
      subject(:column_empty) { described_class.new }

      it "returns true" do
        result = column_empty.empty?
        expect(result).to be(true)
      end
    end

    context "when the column is not empty" do
      subject(:column_not_empty) { described_class.new(five_cells) }

      it "returns false" do
        result = column_not_empty.empty?
        expect(result).to be(false)
      end
    end
  end

  describe "#most_recent_token_index" do
    context "when the column is full" do
      subject(:column_last_index) { described_class.new(six_cells) }

      it "returns the last index" do
        result = column_last_index.most_recent_token_index
        expect(result).to eq(5)
      end
    end

    context "when the column is empty" do
      subject(:column_nil) { described_class.new }

      it "returns nil" do
        result = column_nil.most_recent_token_index
        expect(result).to be_nil
      end
    end

    context "when the column is between empty and full" do
      subject(:column_index) { described_class.new(five_cells) }

      it "returns the most recent token index" do
        result = column_index.most_recent_token_index
        expect(result).to eq(4)
      end
    end
  end
end
