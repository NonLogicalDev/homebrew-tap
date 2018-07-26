class NlTimewarrior < Formula
  desc "Command-line time tracking application"
  homepage "https://taskwarrior.org/docs/timewarrior/"

  head "https://github.com/NonLogicalDev/fork.util.timewarrior.git", :branch => "dev"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/".taskwarrior").mkpath
    (testpath/".taskwarrior/data.time").mkpath
    (testpath/".taskwarrior/data.time/extensions").mkpath
    touch testpath/".taskwarrior/timewarrior.cfg"

    assert_match "Tracking foo", shell_output("#{bin}/timew start foo")
  end
end
