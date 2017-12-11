class WordTransformation
	def initialize(start_word, end_word, words_list)
		@start_word = start_word
		@end_word = end_word
		@words_list = words_list
	end
	def is_next_word(a,b)
		count = 0
		n = a.length
		n.times do |i|
			count += 1 if a[i] != b[i]
			break if count > 1
		end
		count == 1 ? true : false
		
	end

	def get_distance_tree
		q = Queue.new
		q.push(@start_word)
		dist_tree = Hash.new
		dist_tree[@start_word] = 1
		completed = false
		while(!q.empty?) do
			curr_word = q.pop()
			for w in @words_list do
				if @start_word == @end_word
					dist_tree[@end_word] = dist_tree[@start_word]+1
					completed = true
				elsif is_next_word(curr_word, w) && (!dist_tree.keys.include? w)
					dist_tree[w] = dist_tree[curr_word]+1
					q.push(w)
					completed = true if w == @end_word
				end
				return dist_tree if completed == true
			end
		end
	end

	def get_shortest_path		
		distance_tree = get_distance_tree
		result = []
		curr_queue = []
		get_possibilities(@start_word, @end_word, @words_list, distance_tree, curr_queue, result)
		result
	end

	def get_possibilities(start_word, end_word, words_list, distance_tree, curr_queue, result)
		if start_word == end_word
			list = Array.new(curr_queue)
			list.push(start_word)
			result.push(list)
			return
		end
		curr_queue.push(start_word)
		start_word.length.times do |i|
			chars = start_word.split("")
			("a".."z").to_a.each do |c|
				chars[i] = c
				next_word = chars.join
				if (distance_tree.keys.include?(next_word) && (distance_tree[next_word] == distance_tree[start_word] + 1 ))
					get_possibilities(next_word, end_word, words_list, distance_tree, curr_queue, result)
				end
			end

		end
		curr_queue.delete_at(curr_queue.size-1)
	end
end

start_word = "hit"
end_word = "cog"
words_list = ["hot", "dot", "dog", "lot", "log", "cog"]
wrdt = WordTransformation.new(start_word, end_word, words_list)
result = wrdt.get_shortest_path
puts "Start Word : #{start_word}"
puts "End Word : #{end_word}"
puts "Words List : #{words_list}"
puts
result.each do |r|
	puts "Shortest Length is #{r.length}"
	puts r.join(" -> ")
	puts 
end