require "spec_helper"

RSpec.describe WordTransformation do
	before :all do
		start_word = "hit"
		end_word = "cog"
		word_list = ["hot", "dot", "dog", "lot", "log", "cog"]
		@wt_object = WordTransformation.new(start_word,end_word,word_list)
	end	

	context "method is_next_word" do
		it "should return true while passing next word" do
			expect(@wt_object.is_next_word("hit", "hot")).to be_truthy
		end
		it "should return false while passing wrong word which is not next"do
			expect(@wt_object.is_next_word("hit", "dot")).to be_falsey
		end
	end

	context "method get_distance_tree" do
		it "should return retun an organized tree" do
			expect(@wt_object.get_distance_tree).to eq({"hit"=>1, "hot"=>2, "dot"=>3, "lot"=>3, "dog"=>4, "log"=>4, "cog"=>5})
		end
	end

	context "method get_shortest_path" do
		it "should return shortest path(s)" do
			expect(@wt_object.get_shortest_path).to eq([['hit', "hot", "dot", "dog","cog"], ['hit', "hot", "lot", "log", "cog"]])
		end
	end
end
