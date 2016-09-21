<form method="post" enctype="multipart/form-data" class="sap-form form-horizontal">
	{preventCsrf}

	<input type="hidden" name="old_name" value="{if isset($item.username)}{$item.username|escape:'html'}{/if}">
	<input type="hidden" name="id" value="{if 'edit' == $pageAction}{$id}{/if}">

	{if -1 != $item.parent_id}
		{capture name='general' append='fieldset_before'}
			<div id="parent_fieldzone" class="row">
				<label class="col col-lg-2 control-label">
					{lang key='field_category_id'}<br>
					<a href="#" class="categories-toggle" id="js-tree-toggler">{lang key='open_close'}</a>
				</label>
				<div class="col col-lg-4">
					<input type="text" id="js-category-label" value="{if $parent}{$parent.title}{else}{lang key='field_category_id_annotation'}{/if}" disabled>
					<div id="js-tree" class="tree categories-tree"{if iaCore::ACTION_EDIT == $pageAction} style="display:none"{/if}></div>
					<input type="hidden" name="parent_id" id="input-category" value="{$item.parent_id}">
				</div>
			</div>
			{ia_add_js}
$(function()
{
	var current_category = $('input[name="id"]').val();

	new IntelliTree(
	{
		url: intelli.config.ia_url + 'directory/categories/read.json?get=tree&current_category=' + current_category,
		onchange: intelli.fillUrlBox,
		nodeOpened: [0,{if isset($item.parents)}{$item.parents}{/if}],
		nodeSelected: {$parent.id}
	});
});
			{/ia_add_js}
		{/capture}

		{capture name='title' append='field_after'}
			<div id="title_alias" class="row">
				<label for="" class="col col-lg-2 control-label">{lang key='title_alias'}</label>
				<div class="col col-lg-4">
					<input type="text" name="title_alias" id="field_title_alias" value="{if isset($item.title_alias)}{$item.title_alias}{/if}">
					<p class="help-block text-break-word">{lang key='page_url_will_be'}: <span class="text-danger" id="title_url">{$smarty.const.IA_URL}{if $item.title_alias && $parent.title_alias}{$parent.title_alias}{$item.title_alias}/{/if}</span></p>
				</div>
			</div>
		{/capture}

		{$exceptions = array()}
	{else}
		<input type="hidden" name="parent_id" id="parent_id" value="-1">

		{$exceptions = ['meta_description', 'meta_keywords']}
	{/if}

	{include file='field-type-content-fieldset.tpl' isSystem=true exceptions=$exceptions}
</form>
{ia_add_media files='tree, js:_IA_URL_packages/directory/js/admin/categories'}