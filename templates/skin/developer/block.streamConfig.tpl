{literal}
<script language="JavaScript" type="text/javascript">
    document.addEvent('domready', function() {
        new Autocompleter.Request.LS.JSON($('stream_users_complete'), aRouter['ajax']+'autocompleter/user/?security_ls_key='+LIVESTREET_SECURITY_KEY, {
            'indicatorClass': 'autocompleter-loading', // class added to the input during request
            'minLength': 1, // We need at least 1 character
            'selectMode': 'pick', // Instant completion
            'multiple': false, // Tag support, by default comma separated
        });
        $('stream_users_complete').addEvent('keydown', function (event) {
            if (event.key == 'enter') {
                lsStream.appendUser()
            }
        });
	});
</script>
{/literal}


<div class="block stream-settings">
	<h2>{$aLang.stream_block_config_title}</h2>
	
	<p class="sp-note">{$aLang.stream_settings_note_filter}</p>

	<ul class="stream-settings-filter">
		{foreach from=$STREAM_EVENT_TYPE item=aEventType}
			<li><label><input class="streamEventTypeCheckbox input-checkbox"
						type="checkbox"
						id="strn_et_{$aEventType.id}"
						{math equation="x & y" x=$aEventType.id y=$aStreamConfig.event_types assign=bStreamChecked}
						{if $bStreamChecked}checked="checked"{/if}
						onClick="if ($(this).get('checked')) { lsStream.switchEventType( {$aEventType.id}) } else { lsStream.switchEventType( {$aEventType.id})  } " />
				{$aEventType.name}</label>
			</li>
		{/foreach}
	</ul>
	
	
	<h3>{$aLang.stream_block_users_title}</h3>
	
	<p class="sp-note">{$aLang.stream_settings_note_follow_user}</p>
	
	<div class="stream-settings-userlist">
		<p><input type="text" id="stream_users_complete" autocomplete="off" />
		<a href="javascript:lsStream.appendUser()">{$aLang.stream_block_config_append}</a></p>
		
		<ul id="userfeed_block_users_list">
			{if count($aStreamSubscribedUsers)}
				{foreach from=$aStreamSubscribedUsers item=oUser}
					{assign var=iUserId value=$oUser->getId()}
					{if !isset($aStreamFriends.$iUserId)}
						<li><input class="streamUserCheckbox input-checkbox"
									type="checkbox"
									id="strm_u_{$iUserId}"
									checked="checked"
									onClick="if ($(this).get('checked')) { lsStream.subscribe({$iUserId}) } else { lsStream.unsubscribe({$iUserId}) } " />
							<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
						</li>
					{/if}
				{/foreach}
			{/if}
		</ul>
	</div>
	
	
	{if count($aStreamFriends)}
		<h3>{$aLang.stream_block_users_friends}</h3>
		
		<p class="sp-note">{$aLang.stream_settings_note_follow_friend}</p>
		
		<ul class="stream-settings-friends">
			{foreach from=$aStreamFriends item=oUser}
				{assign var=iUserId value=$oUser->getId()}
				<li><input class="streamUserCheckbox input-checkbox"
							type="checkbox"
							id="strm_u_{$iUserId}"
							{if isset($aStreamSubscribedUsers.$iUserId)} checked="checked"{/if}
							onClick="if ($(this).get('checked')) { lsStream.subscribe({$iUserId}) } else { lsStream.unsubscribe({$iUserId}) } " />
					<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
				</li>
			{/foreach}
		</ul>
	{/if}
</div>