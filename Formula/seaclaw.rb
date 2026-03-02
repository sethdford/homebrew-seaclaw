# typed: false
# frozen_string_literal: true

class Seaclaw < Formula
  desc "Autonomous AI assistant runtime — minimal C11 binary"
  homepage "https://sethdford.github.io/seaclaw/"
  url "https://github.com/sethdford/seaclaw/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f7e3132e558f30235d4e0a02e0c2b8fde6885620dfe584b70a990bc60b38f06e"
  license "MIT"
  head "https://github.com/sethdford/seaclaw.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "sqlite"
  depends_on "curl"

  def install
    args = %w[
      -DCMAKE_BUILD_TYPE=MinSizeRel
      -DSC_ENABLE_LTO=ON
      -DSC_ENABLE_SQLITE=ON
      -DSC_ENABLE_CURL=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build", "--target", "seaclaw"
    bin.install "build/seaclaw"
    bash_completion.install "completions/seaclaw.bash" => "seaclaw"
    zsh_completion.install "completions/seaclaw.zsh" => "_seaclaw"
  end

  test do
    assert_match "seaclaw", shell_output("#{bin}/seaclaw --version")
    system "#{bin}/seaclaw", "--help"
  end
end
