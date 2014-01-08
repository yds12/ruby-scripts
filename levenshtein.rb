class Levenshtein
  attr_accessor :seq1, :seq2
  GAP = '-'

  def align s1, s2, show = false
    @seq1 = ''
    @seq2 = ''

    m = build_matrix s1.size + 1, s2.size + 1

    (s1.size + 1).times do |i|
      (s2.size + 1).times do |j|
        set_matrix m, i, j, s1, s2
      end
    end

    i = s1.size
    j = s2.size

    until i == 0 and j == 0
      up = m[i - 1][j]
      left = m[i][j - 1]
      diag = m[i - 1][j - 1]
      min = [up, left, diag].min
      
      if diag == min
        i -= 1
        j -= 1
        @seq1 += s1[i]
        @seq2 += s2[j]
      elsif up == min
        i -= 1
        @seq1 += s1[i]
        @seq2 += GAP
      else
        j -= 1
        @seq1 += GAP
        @seq2 += s2[j]
      end
    end

    @seq1.reverse!
    @seq2.reverse!

    dist = 0

    @seq1.size.times do |i|
      if @seq1[i] != @seq2[i]
        if @seq1[i] == GAP or @seq2[i] == GAP
          dist += 1
        else
          dist += 2
        end
      end
    end

    if show
      puts @seq1
      puts @seq2
    end

    dist
  end

private

  def set_matrix m, i, j, s1, s2
    if i == 0
      m[i][j] = j
    elsif j == 0
      m[i][j] = i
    else
      delete = m[i - 1][j] + 1
      insert = m[i][j - 1] + 1

      replace = m[i - 1][j - 1]
      replace += 2 if s1[i - 1] != s2[j - 1]

      m[i][j] = [delete, insert, replace].min
    end
  end

  def build_matrix i, j
    m = []

    i.times do |ii|
      m[ii] = []

      j.times do |jj|
        m[ii][jj] = 0
      end
    end

    m
  end

  def print_matrix m, s1, s2
    puts s2.chars.unshift(' ').unshift(' ').join("\t")

    s1 = s1.chars.unshift(' ').join
    (s1.size).times do |i|
      puts m[i].unshift(s1.chars[i]).join("\t")
    end
  end
end
