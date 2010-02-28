package WWW::Anvil::Schema::Result::Meta;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

WWW::Anvil::Schema::Result::Meta

=cut

__PACKAGE__->table("meta");

=head1 ACCESSORS

=head2 id

  data_type: integer
  default_value: nextval('meta_id_seq'::regclass)
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: text
  default_value: undef
  is_nullable: 0

=head2 value

  data_type: text
  default_value: undef
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    default_value     => \"nextval('meta_id_seq'::regclass)",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "name",
  { data_type => "text", default_value => undef, is_nullable => 0 },
  "value",
  { data_type => "text", default_value => undef, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2010-02-28 16:57:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IQnH6E5yEQ84maVH0Tmn0w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
