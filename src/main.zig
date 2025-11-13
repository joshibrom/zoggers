const std = @import("std");

const MarkupTag = enum {
    file,
    html,
};
const Markup = union(MarkupTag) {
    file: []const u8,
    html: []const u8,
};

const Post = struct {
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

const posts: [2]Post = [_]Post{
    Post{
        .title = .{ .long = "Some long title", .short = "A title" },
        .description = "Desc",
        .date = "11-12-25",
        .is_published = true,
        .markup = .{ .file = "content/foo.html" },
    },
    Post{
        .title = .{ .long = "Another title", .short = "Another title" },
        .description = "Desc",
        .date = "11-12-25",
        .is_published = false,
        .markup = .{ .html = "<em>Some content</em>" },
    },
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    for (posts) |p| {
        std.debug.print("{s}\n", .{try p.get_markup(allocator)});
    }
}
