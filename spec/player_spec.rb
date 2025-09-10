require_relative "../lib/player"

describe Player do
  subject(:player) { described_class.new("player", "🔴") }

  describe "#activate" do
    it "activates player" do
      player.activate
      result = player.active
      expect(result).to be(true)
    end

    it "returns true" do
      result = player.activate
      expect(result).to be(true)
    end
  end

  describe "#deactivate" do
    before { player.instance_variable_set(:@active, true) }

    it "deactivates player" do
      player.deactivate
      result = player.active
      expect(result).to be(false)
    end

    it "returns false" do
      result = player.deactivate
      expect(result).to be(false)
    end
  end
end
