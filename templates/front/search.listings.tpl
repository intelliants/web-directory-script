{if !empty($listings)}
    <div class="ia-items ia-items--cards">
        {foreach $listings as $listing}
            {include 'extra:directory/list-listings'}
        {/foreach}
    </div>
{else}
    <div class="alert alert-info">{lang key='no_web_listings2'}</div>
{/if}