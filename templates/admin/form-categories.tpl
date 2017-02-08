<form method="post" enctype="multipart/form-data" class="sap-form form-horizontal">
	{preventCsrf}

	<input type="hidden" name="id" value="{if iaCore::ACTION_EDIT == $pageAction}{$id}{/if}">

	{if -1 != $item.parent_id}
		{capture name='general' append='fieldset_before'}
			{include 'tree.tpl' url="{$smarty.const.IA_ADMIN_URL}directory/categories/tree.json?cid={$id}"}
			{*<div id="parent_fieldzone" class="row">
				<label class="col col-lg-2 control-label">
					{lang key='parent_category'}<br>
					<a href="#" class="categories-toggle" id="js-tree-toggler">{lang key='open_close'}</a>
				</label>
				<div class="col col-lg-4">
					<input type="text" id="js-category-label" value="{if $parent}{$parent.title|escape:'html'}{else}{lang key='field_category_id'}{/if}" disabled>
					<div id="js-tree" class="tree categories-tree"{if iaCore::ACTION_EDIT == $pageAction} style="display:none"{/if}></div>
					<input type="hidden" name="parent_id" id="input-category" value="{$item.parent_id}">
				</div>
			</div>
			{ia_add_js}
$(function()
{
	intelli.cid = $('input[name="id"]').val();

	new IntelliTree(
	{
		url: intelli.config.admin_url + '/directory/categories/tree.json?cid=' + intelli.cid,
		onchange: intelli.fillUrlBox,
		nodeOpened: [0,{if isset($item.parents)}{$item.parents}{/if}],
		nodeSelected: {$parent.id}
	});
});
			{/ia_add_js*}
			<div id="crossed_fieldzone" class="row">
				<label class="col col-lg-2 control-label">
					{lang key='crossed_categories'} <span class="label label-info" id="crossed-limit">{count($item.crossed)|default:0}</span><br>
					<a href="#" class="categories-toggle js-categories-toggle" data-toggle="#tree-crossed">{lang key='open_close'}</a>
				</label>
				<div class="col col-lg-4" style="margin: 8px 0">
					<div id="crossed-list">
						{if isset($item.crossed) && $item.crossed}
							{foreach $item.crossed as $crid => $link}
								<span data-id="{$crid}">{$link}</span>{if !$link@last}, {/if}
							{/foreach}
						{else}
							<div class="alert alert-info">{lang key='no_crossed_categories'}</div>
						{/if}
					</div>

					<div id="tree-crossed" class="tree categories-tree"{if (isset($item.crossed) && $item.crossed) || ('edit' == $pageAction)} style="display:none"{/if}></div>
					<input type="hidden" id="crossed" name="crossed" value="{if isset($item.crossed) && $item.crossed}{','|implode:array_keys($item.crossed)}{elseif isset($smarty.post.crossed)}{$smarty.post.crossed}{/if}">
				</div>
			</div>
		{/capture}

		{capture name='title' append='field_after'}
			<div id="title_alias" class="row">
				<label for="" class="col col-lg-2 control-label">{lang key='title_alias'}</label>
				<div class="col col-lg-4">
					<input type="text" name="title_alias" id="field_title_alias" value="{if isset($item.title_alias)}{$item.title_alias}{/if}">
					<p class="help-block text-break-word">{lang key='page_url_will_be'}: <span class="text-danger" id="title_url">{$smarty.const.IA_URL}{if isset($item.title_alias) && isset($parent.title_alias)}{$parent.title_alias}{$item.title_alias}/{/if}</span></p>
				</div>
			</div>
		{/capture}

		{$exceptions = array()}
	{else}
		<input type="hidden" name="parent_id" id="parent_id" value="-1">

		{$exceptions = ['meta_description', 'meta_keywords', 'icon']}
	{/if}

	{include 'field-type-content-fieldset.tpl' isSystem=true exceptions=$exceptions}
</form>
{ia_add_media files='tree, js:_IA_URL_packages/directory/js/admin/categories'}