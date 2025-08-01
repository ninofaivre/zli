const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Optional: expose module if reused
    const rootModule = b.addModule("zli", .{
        .root_source_file = b.path("src/zli.zig"),
        .target = target,
        .optimize = optimize,
        .single_threaded = false,
    });

    // Test runner
    const lib_test = b.addTest(.{
        .root_module = rootModule,
    });

    const run_test = b.addRunArtifact(lib_test);
    run_test.has_side_effects = true;

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_test.step);
}
