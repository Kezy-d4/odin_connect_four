require_relative "../lib/adjacent_lines"

describe AdjacentLines do
  describe "#select_in_bounds_lines" do
    context "when the cell coordinates are [0, 0] (bottom left of the board)" do
      subject(:adjacent_lines_bottom_left) { described_class.new([0, 0]) }

      it "returns the top vertical, right horizontal, and top right diagonal" do
        result = adjacent_lines_bottom_left.select_in_bounds_lines
        expect(result).to eq([[[0, 0], [0, 1], [0, 2], [0, 3]],
                              [[0, 0], [1, 0], [2, 0], [3, 0]],
                              [[0, 0], [1, 1], [2, 2], [3, 3]]])
      end
    end

    context "when the cell coordinates are [6, 5] (top right of the board)" do
      subject(:adjacent_lines_top_right) { described_class.new([6, 5]) }

      it "returns the bottom vertical, left horizontal, and bottom left diagonal" do
        result = adjacent_lines_top_right.select_in_bounds_lines
        expect(result).to eq([[[6, 5], [6, 4], [6, 3], [6, 2]],
                              [[6, 5], [5, 5], [4, 5], [3, 5]],
                              [[6, 5], [5, 4], [4, 3], [3, 2]]])
      end
    end

    context "when the cell coordinates are [0, 5] (top left of the board)" do
      subject(:adjacent_lines_top_left) { described_class.new([0, 5]) }

      it "returns the bottom vertical, right horizontal, and bottom right diagonal" do
        result = adjacent_lines_top_left.select_in_bounds_lines
        expect(result).to eq([[[0, 5], [0, 4], [0, 3], [0, 2]],
                              [[0, 5], [1, 5], [2, 5], [3, 5]],
                              [[0, 5], [1, 4], [2, 3], [3, 2]]])
      end
    end

    context "when the cell coordinates are [6, 0] (bottom right of the board)" do
      subject(:adjacent_lines_bottom_right) { described_class.new([6, 0]) }

      it "returns the top vertical, left horizontal, and top left diagonal" do
        result = adjacent_lines_bottom_right.select_in_bounds_lines
        expect(result).to eq([[[6, 0], [6, 1], [6, 2], [6, 3]],
                              [[6, 0], [5, 0], [4, 0], [3, 0]],
                              [[6, 0], [5, 1], [4, 2], [3, 3]]])
      end
    end
  end
end
