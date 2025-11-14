const std = @import("std");

pub const MarkupTag = enum {
    file,
    html,
};
pub const Markup = union(MarkupTag) {
    file: []const u8,
    html: []const u8,
};

pub const PageTypeTag = enum {
    home,
    post,
};

pub const PageType = union(PageTypeTag) {
    home: Home,
    post: Post,
};

pub const Page = struct {
    const Self = @This();

    page_type: PageType,
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

pub const Post = struct {
    title: struct { short: []const u8, long: []const u8 },
    description: []const u8,
    post_path: []const u8,
    date: []const u8,
    is_published: bool,
};

pub const Home = struct {
    title: struct { short: []const u8, long: []const u8 },
    description: []const u8,
    date: []const u8,
};
