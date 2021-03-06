package WWW::Anvil::Schema::Result::VideoTag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

WWW::Anvil::Schema::Result::VideoTag

=cut

__PACKAGE__->table("video_tag");

=head1 ACCESSORS

=head2 video_id

  data_type: integer
  default_value: undef
  is_foreign_key: 1
  is_nullable: 0

=head2 tag_id

  data_type: integer
  default_value: undef
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "video_id",
  {
    data_type      => "integer",
    default_value  => undef,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "tag_id",
  {
    data_type      => "integer",
    default_value  => undef,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);
__PACKAGE__->set_primary_key("video_id", "tag_id");

=head1 RELATIONS

=head2 tag

Type: belongs_to

Related object: L<WWW::Anvil::Schema::Result::Tag>

=cut

__PACKAGE__->belongs_to(
  "tag",
  "WWW::Anvil::Schema::Result::Tag",
  { id => "tag_id" },
  {},
);

=head2 video

Type: belongs_to

Related object: L<WWW::Anvil::Schema::Result::Video>

=cut

__PACKAGE__->belongs_to(
  "video",
  "WWW::Anvil::Schema::Result::Video",
  { id => "video_id" },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2010-02-28 16:57:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KXZBejSyPJ/kH8vApnbUaQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
