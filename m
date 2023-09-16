Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24FEC2BA12
	for <linux-wpan@archiver.kernel.org>; Sat, 16 Sep 2023 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjIPPgw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 16 Sep 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjIPPgl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 16 Sep 2023 11:36:41 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D08CE3
        for <linux-wpan@vger.kernel.org>; Sat, 16 Sep 2023 08:36:36 -0700 (PDT)
Received: from [192.168.2.51] (p4fe718a3.dip0.t-ipconnect.de [79.231.24.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 593BFC0DE5;
        Sat, 16 Sep 2023 17:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1694878594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+pWnZGcjrSaHoFebC9fPz9ELWwEFtCKjK1r3e3OnXM=;
        b=OvVl5wEMcBL7nS5T4qdGyP643NjLRUqB+8AZMo1pm4b3NCZmC1+keHv/xipTfbtXF5g42L
        cNwaoBwv5JqorK5TzmC9IPLUEGc800whz691VdPswal/pMkIRlkbzlSMl+WcsSNT7I8tG2
        TEdKuBkkdmLn4wABJEDXwy6/a5hu7ei1Xns35Tn53GkoFy1oBsvQacvlDLUR0e0sSOA9bB
        vNOiLu2O7Zt/TLZwQcZdQ8QANGmTuofiDbiGvm9yleI+9GwR0yL8M7bi58ojQKt8qO4IaQ
        aSIyGQxh4Rd2wYIOdJaZkYPy8Dk4IS4WUg0ku6jaCXqhU705s1mlZfvWNsZZmw==
Message-ID: <7b9b1b97-7c02-06b3-7a84-db1f33784be3@datenfreihafen.org>
Date:   Sat, 16 Sep 2023 17:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH wpan-next v2 07/11] mac802154: Handle association requests
 from peers
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
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
 <20230901170501.1066321-8-miquel.raynal@bootlin.com>
Content-Language: en-US
In-Reply-To: <20230901170501.1066321-8-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Miquel

On 01.09.23 19:04, Miquel Raynal wrote:
> Coordinators may have to handle association requests from peers which
> want to join the PAN. The logic involves:
> - Acknowledging the request (done by hardware)
> - If requested, a random short address that is free on this PAN should
>    be chosen for the device.
> - Sending an association response with the short address allocated for
>    the peer and expecting it to be ack'ed.
> 
> If anything fails during this procedure, the peer is considered not
> associated.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   include/net/cfg802154.h         |   7 ++
>   include/net/ieee802154_netdev.h |   6 ++
>   net/ieee802154/core.c           |   7 ++
>   net/ieee802154/pan.c            |  30 +++++++
>   net/mac802154/ieee802154_i.h    |   2 +
>   net/mac802154/rx.c              |   8 ++
>   net/mac802154/scan.c            | 147 ++++++++++++++++++++++++++++++++
>   7 files changed, 207 insertions(+)
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index c79ff560f400..20ccc8f5da87 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -583,4 +583,11 @@ struct ieee802154_pan_device *
>   cfg802154_device_is_child(struct wpan_dev *wpan_dev,
>   			  struct ieee802154_addr *target);
>   
> +/**
> + * cfg802154_get_free_short_addr - Get a free address among the known devices
> + * @wpan_dev: the wpan device
> + * @return: a random short address expectedly unused on our PAN
> + */
> +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev);
> +
>   #endif /* __NET_CFG802154_H */
> diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
> index 16194356cfe7..4de858f9929e 100644
> --- a/include/net/ieee802154_netdev.h
> +++ b/include/net/ieee802154_netdev.h
> @@ -211,6 +211,12 @@ struct ieee802154_association_req_frame {
>   	struct ieee802154_assoc_req_pl assoc_req_pl;
>   };
>   
> +struct ieee802154_association_resp_frame {
> +	struct ieee802154_hdr mhr;
> +	struct ieee802154_mac_cmd_pl mac_pl;
> +	struct ieee802154_assoc_resp_pl assoc_resp_pl;
> +};
> +
>   struct ieee802154_disassociation_notif_frame {
>   	struct ieee802154_hdr mhr;
>   	struct ieee802154_mac_cmd_pl mac_pl;
> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index be958727ccdf..790965018118 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -200,11 +200,18 @@ EXPORT_SYMBOL(wpan_phy_free);
>   
>   static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
>   {
> +	struct ieee802154_pan_device *child, *tmp;
> +
>   	mutex_lock(&wpan_dev->association_lock);
>   
>   	kfree(wpan_dev->parent);
>   	wpan_dev->parent = NULL;
>   
> +	list_for_each_entry_safe(child, tmp, &wpan_dev->children, node) {
> +		list_del(&child->node);
> +		kfree(child);
> +	}
> +
>   	wpan_dev->association_generation++;
>   
>   	mutex_unlock(&wpan_dev->association_lock);
> diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> index 477e8dad0cf0..364abb89d156 100644
> --- a/net/ieee802154/pan.c
> +++ b/net/ieee802154/pan.c
> @@ -66,3 +66,33 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
>   	return NULL;
>   }
>   EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> +
> +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
> +{
> +	struct ieee802154_pan_device *child;
> +	__le16 addr;
> +
> +	lockdep_assert_held(&wpan_dev->association_lock);
> +
> +	do {
> +		get_random_bytes(&addr, 2);
> +		if (addr == cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST) ||
> +		    addr == cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC))
> +			continue;
> +
> +		if (wpan_dev->short_addr == addr)
> +			continue;
> +
> +		if (wpan_dev->parent && wpan_dev->parent->short_addr == addr)
> +			continue;
> +
> +		list_for_each_entry(child, &wpan_dev->children, node)
> +			if (child->short_addr == addr)
> +				continue;
> +
> +		break;
> +	} while (1);
> +
> +	return addr;
> +}
> +EXPORT_SYMBOL_GPL(cfg802154_get_free_short_addr);
> diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> index 92252f86c69c..432bfa87249e 100644
> --- a/net/mac802154/ieee802154_i.h
> +++ b/net/mac802154/ieee802154_i.h
> @@ -318,6 +318,8 @@ static inline bool mac802154_is_associating(struct ieee802154_local *local)
>   int mac802154_send_disassociation_notif(struct ieee802154_sub_if_data *sdata,
>   					struct ieee802154_pan_device *target,
>   					u8 reason);
> +int mac802154_process_association_req(struct ieee802154_sub_if_data *sdata,
> +				      struct sk_buff *skb);
>   
>   /* interface handling */
>   int ieee802154_iface_init(void);
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index d0e08613a36b..96040b63a4fc 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -102,6 +102,14 @@ void mac802154_rx_mac_cmd_worker(struct work_struct *work)
>   		mac802154_process_association_resp(mac_pkt->sdata, mac_pkt->skb);
>   		break;
>   
> +	case IEEE802154_CMD_ASSOCIATION_REQ:
> +		dev_dbg(&mac_pkt->sdata->dev->dev, "processing ASSOC REQ\n");
> +		if (mac_pkt->sdata->wpan_dev.iftype != NL802154_IFTYPE_COORD)
> +			break;
> +
> +		mac802154_process_association_req(mac_pkt->sdata, mac_pkt->skb);
> +		break;
> +
>   	default:
>   		break;
>   	}
> diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> index e2f2e1235ec6..9f55b2314fe5 100644
> --- a/net/mac802154/scan.c
> +++ b/net/mac802154/scan.c
> @@ -697,3 +697,150 @@ int mac802154_send_disassociation_notif(struct ieee802154_sub_if_data *sdata,
>   	dev_dbg(&sdata->dev->dev, "DISASSOC ACK received from %8phC\n", &teaddr);
>   	return 0;
>   }
> +
> +static int
> +mac802154_send_association_resp_locked(struct ieee802154_sub_if_data *sdata,
> +				       struct ieee802154_pan_device *target,
> +				       struct ieee802154_assoc_resp_pl *assoc_resp_pl)
> +{
> +	u64 teaddr = swab64((__force u64)target->extended_addr);
> +	struct ieee802154_association_resp_frame frame = {};
> +	struct ieee802154_local *local = sdata->local;
> +	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
> +	struct sk_buff *skb;
> +	int ret;
> +
> +	frame.mhr.fc.type = IEEE802154_FC_TYPE_MAC_CMD;
> +	frame.mhr.fc.security_enabled = 0;
> +	frame.mhr.fc.frame_pending = 0;
> +	frame.mhr.fc.ack_request = 1; /* We always expect an ack here */
> +	frame.mhr.fc.intra_pan = 1;
> +	frame.mhr.fc.dest_addr_mode = IEEE802154_EXTENDED_ADDRESSING;
> +	frame.mhr.fc.version = IEEE802154_2003_STD;
> +	frame.mhr.fc.source_addr_mode = IEEE802154_EXTENDED_ADDRESSING;
> +	frame.mhr.seq = 10;

Where does the 10 come from and what is the meaning?

regards
Stefan Schmidt
