Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF9DC46CA1
	for <linux-wpan@archiver.kernel.org>; Mon, 18 Sep 2023 16:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjIRQGr (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjIRQGh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Sep 2023 12:06:37 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701059FB;
        Mon, 18 Sep 2023 09:05:17 -0700 (PDT)
Received: from [IPV6:2003:e9:d74f:c0a3:b8f6:e95d:8f78:dac0] (p200300e9d74fc0a3b8f6e95d8f78dac0.dip0.t-ipconnect.de [IPv6:2003:e9:d74f:c0a3:b8f6:e95d:8f78:dac0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id BF87CC022B;
        Mon, 18 Sep 2023 17:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1695051718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMxJwvme9DMZpEInft8cU0mZbNbC2TjVjNfFSKKYXKg=;
        b=wICNrpohZ9JLbkd9dM4hdtBSwjVku71juEU+C8O/9SSXPBS33jSKbB1x2osfKVWYnp584W
        2UPDlwOb45TnqDR2bobpbEIqk2W7hQ9GiaJW6ZYzq/AyV0ciP3OG1PSOr/UuxRfgyZa979
        2IvwthwTKnIOpXvys2NfCz0RdotUwKA/vN/bRJfb8uSKDoluJDxnzhpWuMOLTeav+9a4xM
        V9XDnMZVIQJVGup69/DhiIMAN8jCXax2s+SxLszc8hduoeBlzE2ZOa8011yLsMFRtr2CDc
        HVJC03L3DUQF21pQ7+40A8mmDNTMarwR/FouKiDPK0XzVZcJdj+1wf5UxNktaQ==
Message-ID: <f4ac1b85-be98-e068-4d64-f180a52e0ac7@datenfreihafen.org>
Date:   Mon, 18 Sep 2023 17:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH wpan-next v2 11/11] ieee802154: Give the user the
 association list
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
 <20230901170501.1066321-12-miquel.raynal@bootlin.com>
 <385bff6c-1322-d2ea-16df-6e005888db0b@datenfreihafen.org>
 <20230918090808.37d53674@xps-13>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20230918090808.37d53674@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Miquel.

On 18.09.23 09:08, Miquel Raynal wrote:
> Hi Stefan,
> 
> stefan@datenfreihafen.org wrote on Sat, 16 Sep 2023 17:36:41 +0200:
> 
>> Hello Miquel.
>>
>> On 01.09.23 19:05, Miquel Raynal wrote:
>>> Upon request, we must be able to provide to the user the list of
>>> associations currently in place. Let's add a new netlink command and
>>> attribute for this purpose.
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>>    include/net/nl802154.h    |  18 ++++++-
>>>    net/ieee802154/nl802154.c | 107 ++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 123 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
>>> index 8b26faae49e8..4c752f799957 100644
>>> --- a/include/net/nl802154.h
>>> +++ b/include/net/nl802154.h
>>> @@ -81,6 +81,7 @@ enum nl802154_commands {
>>>    	NL802154_CMD_ASSOCIATE,
>>>    	NL802154_CMD_DISASSOCIATE,
>>>    	NL802154_CMD_SET_MAX_ASSOCIATIONS,
>>> +	NL802154_CMD_LIST_ASSOCIATIONS,
>>>    >   	/* add new commands above here */
>>>    > @@ -151,6 +152,7 @@ enum nl802154_attrs {
>>>    	NL802154_ATTR_SCAN_DONE_REASON,
>>>    	NL802154_ATTR_BEACON_INTERVAL,
>>>    	NL802154_ATTR_MAX_ASSOCIATIONS,
>>> +	NL802154_ATTR_PEER,
>>>    >   	/* add attributes here, update the policy in nl802154.c */
>>>    > @@ -389,8 +391,6 @@ enum nl802154_supported_bool_states {
>>>    	NL802154_SUPPORTED_BOOL_MAX = __NL802154_SUPPORTED_BOOL_AFTER_LAST - 1
>>>    };
>>>    > -#ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
>>> -
>>>    enum nl802154_dev_addr_modes {
>>>    	NL802154_DEV_ADDR_NONE,
>>>    	__NL802154_DEV_ADDR_INVALID,
>>> @@ -410,12 +410,26 @@ enum nl802154_dev_addr_attrs {
>>>    	NL802154_DEV_ADDR_ATTR_SHORT,
>>>    	NL802154_DEV_ADDR_ATTR_EXTENDED,
>>>    	NL802154_DEV_ADDR_ATTR_PAD,
>>> +	NL802154_DEV_ADDR_ATTR_PEER_TYPE,
>>>    >   	/* keep last */
>>>    	__NL802154_DEV_ADDR_ATTR_AFTER_LAST,
>>>    	NL802154_DEV_ADDR_ATTR_MAX = __NL802154_DEV_ADDR_ATTR_AFTER_LAST - 1
>>>    };
>>>    > +enum nl802154_peer_type {
>>> +	NL802154_PEER_TYPE_UNSPEC,
>>> +
>>> +	NL802154_PEER_TYPE_PARENT,
>>> +	NL802154_PEER_TYPE_CHILD,
>>> +
>>> +	/* keep last */
>>> +	__NL802154_PEER_TYPE_AFTER_LAST,
>>> +	NL802154_PEER_TYPE_MAX = __NL802154_PEER_TYPE_AFTER_LAST - 1
>>> +};
>>> +
>>> +#ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
>>> +
>>>    enum nl802154_key_id_modes {
>>>    	NL802154_KEY_ID_MODE_IMPLICIT,
>>>    	NL802154_KEY_ID_MODE_INDEX,
>>> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
>>> index e16e57fc34d0..e26d7cec02ce 100644
>>> --- a/net/ieee802154/nl802154.c
>>> +++ b/net/ieee802154/nl802154.c
>>> @@ -235,6 +235,7 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
>>>    	[NL802154_ATTR_BEACON_INTERVAL] =
>>>    		NLA_POLICY_MAX(NLA_U8, IEEE802154_ACTIVE_SCAN_DURATION),
>>>    	[NL802154_ATTR_MAX_ASSOCIATIONS] = { .type = NLA_U32 },
>>> +	[NL802154_ATTR_PEER] = { .type = NLA_NESTED },
>>>    >   #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
>>>    	[NL802154_ATTR_SEC_ENABLED] = { .type = NLA_U8, },
>>> @@ -1717,6 +1718,107 @@ static int nl802154_set_max_associations(struct sk_buff *skb, struct genl_info *
>>>    	return 0;
>>>    }
>>>    > +static int nl802154_send_peer_info(struct sk_buff *msg,
>>> +				   struct netlink_callback *cb,
>>> +				   u32 seq, int flags,
>>> +				   struct cfg802154_registered_device *rdev,
>>> +				   struct wpan_dev *wpan_dev,
>>> +				   struct ieee802154_pan_device *peer,
>>> +				   enum nl802154_peer_type type)
>>> +{
>>> +	struct nlattr *nla;
>>> +	void *hdr;
>>> +
>>> +	ASSERT_RTNL();
>>> +
>>> +	hdr = nl802154hdr_put(msg, NETLINK_CB(cb->skb).portid, seq, flags,
>>> +			      NL802154_CMD_LIST_ASSOCIATIONS);
>>> +	if (!hdr)
>>> +		return -ENOBUFS;
>>> +
>>> +	genl_dump_check_consistent(cb, hdr);
>>> +
>>> +	if (nla_put_u32(msg, NL802154_ATTR_GENERATION,
>>> +			wpan_dev->association_generation))
>>
>>
>> This one still confuses me. I only ever see it increasing in the code. Did I miss something?
> 
> I think I took inspiration from nl802154_send_wpan_phy() and
> and nl802154_send_iface() which both use an increasing counter to tell
> userspace the "version" of the data that is being sent. If the
> "version" numbers are identical, the user (I guess) can assume nothing
> changed and save itself from parsing the whole payload or something
> like that.
> 
> TBH I just tried here to mimic the existing behavior inside
> nl802154_send_peer_info(), but I will drop that counter with no regrets.

Yes, please drop for now. I does not serve a real purpose at the moment. 
If we need such a mechanism for userspace later we can see how we 
implement it when we have clear use cases.

regards
Stefan Schmidt
