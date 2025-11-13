const std = @import("std");

pub const MarkupTag = enum {
    file,
    html,
};
pub const Markup = union(MarkupTag) {
    file: []const u8,
    html: []const u8,
};

pub const Post = struct {
    const Self = @This();

    title: struct { short: []const u8, long: []const u8 },
    description: []const u8,
    date: []const u8,
    is_published: bool,
    markup: Markup,

    pub fn get_markup(self: Self, allocator: std.mem.Allocator) ![]const u8 {
        return switch (self.markup) {
            .file => |fname| try std.fs.cwd().readFileAlloc(
                allocator,
                fname,
                1024 * 1024,
            ),
            .html => |htmls| htmls,
        };
    }
};
