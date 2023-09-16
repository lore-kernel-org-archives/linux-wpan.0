Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D127C46CA1
	for <linux-wpan@archiver.kernel.org>; Sat, 16 Sep 2023 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjIPPgw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 16 Sep 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjIPPgg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 16 Sep 2023 11:36:36 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C4CE3
        for <linux-wpan@vger.kernel.org>; Sat, 16 Sep 2023 08:36:29 -0700 (PDT)
Received: from [192.168.2.51] (p4fe718a3.dip0.t-ipconnect.de [79.231.24.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 4A831C0270;
        Sat, 16 Sep 2023 17:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1694878578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLNPP6HB8qBQRUNSmQElKva/41IvPL9YbKIHWl8GTXk=;
        b=L+GtHgBl4KLUXwee+wbGGELbnoPEZrIdXcTyHMXH9fBrVSJnGV9qHxaVKhVIx2u+YvYLmd
        auL/748VSS6r1RNgoZaWZzleIJDtn7Hi6O1efKapV/psscbXDBCgrUw6TLHH4VUKwCKlz9
        H5/frsiOi5ytyZi8Oo65fisSnqX+qG2vKx1+bLy5ugaEZC8+BHoxHbf0/65payQDf9zV7d
        ImLYbaa4/U+G/+hts+Rc04OeCpaEP0Jh3PYBtd6C3pARLhYP83qzmy+WE4n0/TZSLWsVqW
        //3UIJM0fjkwrxxNwTFtefGRPW1fICjBP/fsXQ6KMhivA6ooFI1DTXjZ7Mh7hQ==
Message-ID: <32cfbf0f-7ac8-5a4c-d9cd-9650a64fc0ea@datenfreihafen.org>
Date:   Sat, 16 Sep 2023 17:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH wpan-next v2 02/11] ieee802154: Internal PAN management
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
 <20230901170501.1066321-3-miquel.raynal@bootlin.com>
Content-Language: en-US
In-Reply-To: <20230901170501.1066321-3-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Miquel.

On 01.09.23 19:04, Miquel Raynal wrote:
> Introduce structures to describe peer devices in a PAN as well as a few
> related helpers. We basically care about:
> - Our unique parent after associating with a coordinator.
> - Peer devices, children, which successfully associated with us.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   include/net/cfg802154.h | 46 ++++++++++++++++++++++++++++
>   net/ieee802154/Makefile |  2 +-
>   net/ieee802154/core.c   |  2 ++
>   net/ieee802154/pan.c    | 66 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 115 insertions(+), 1 deletion(-)
>   create mode 100644 net/ieee802154/pan.c
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index f79ce133e51a..6c7193b4873c 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -303,6 +303,22 @@ struct ieee802154_coord_desc {
>   	bool gts_permit;
>   };
>   
> +/**
> + * struct ieee802154_pan_device - PAN device information
> + * @pan_id: the PAN ID of this device
> + * @mode: the preferred mode to reach the device
> + * @short_addr: the short address of this device
> + * @extended_addr: the extended address of this device
> + * @node: the list node
> + */
> +struct ieee802154_pan_device {
> +	__le16 pan_id;
> +	u8 mode;
> +	__le16 short_addr;
> +	__le64 extended_addr;
> +	struct list_head node;
> +};
> +
>   /**
>    * struct cfg802154_scan_request - Scan request
>    *
> @@ -478,6 +494,11 @@ struct wpan_dev {
>   
>   	/* fallback for acknowledgment bit setting */
>   	bool ackreq;
> +
> +	/* Associations */
> +	struct mutex association_lock;
> +	struct ieee802154_pan_device *parent;
> +	struct list_head children;
>   };
>   
>   #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
> @@ -529,4 +550,29 @@ static inline const char *wpan_phy_name(struct wpan_phy *phy)
>   void ieee802154_configure_durations(struct wpan_phy *phy,
>   				    unsigned int page, unsigned int channel);
>   
> +/**
> + * cfg802154_device_is_associated - Checks whether we are associated to any device
> + * @wpan_dev: the wpan device

Missing return value documentation.

> + */
> +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev);
> +
> +/**
> + * cfg802154_device_is_parent - Checks if a device is our coordinator
> + * @wpan_dev: the wpan device
> + * @target: the expected parent
> + * @return: true if @target is our coordinator
> + */
> +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> +				struct ieee802154_addr *target);
> +
> +/**
> + * cfg802154_device_is_child - Checks whether a device is associated to us
> + * @wpan_dev: the wpan device
> + * @target: the expected child
> + * @return: the PAN device
> + */
> +struct ieee802154_pan_device *
> +cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> +			  struct ieee802154_addr *target);
> +
>   #endif /* __NET_CFG802154_H */
> diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
> index f05b7bdae2aa..7bce67673e83 100644
> --- a/net/ieee802154/Makefile
> +++ b/net/ieee802154/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
>   obj-y += 6lowpan/
>   
>   ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
> -                header_ops.o sysfs.o nl802154.o trace.o
> +                header_ops.o sysfs.o nl802154.o trace.o pan.o
>   ieee802154_socket-y := socket.o
>   
>   CFLAGS_trace.o := -I$(src)
> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index 57546e07e06a..cd69bdbfd59f 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -276,6 +276,8 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
>   		wpan_dev->identifier = ++rdev->wpan_dev_id;
>   		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
>   		rdev->devlist_generation++;
> +		mutex_init(&wpan_dev->association_lock);
> +		INIT_LIST_HEAD(&wpan_dev->children);
>   
>   		wpan_dev->netdev = dev;
>   		break;
> diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> new file mode 100644
> index 000000000000..e2a12a42ba2b
> --- /dev/null
> +++ b/net/ieee802154/pan.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IEEE 802.15.4 PAN management
> + *
> + * Copyright (C) 2021 Qorvo US, Inc
> + * Authors:
> + *   - David Girault <david.girault@qorvo.com>
> + *   - Miquel Raynal <miquel.raynal@bootlin.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <net/cfg802154.h>
> +#include <net/af_ieee802154.h>
> +
> +static bool cfg802154_same_addr(struct ieee802154_pan_device *a,
> +				struct ieee802154_addr *b)
> +{
> +	if (!a || !b)
> +		return false;
> +
> +	switch (b->mode) {
> +	case IEEE802154_ADDR_SHORT:
> +		return a->short_addr == b->short_addr;
> +	case IEEE802154_ADDR_LONG:
> +		return a->extended_addr == b->extended_addr;
> +	default:
> +		return false;
> +	}
> +}

Don't we already have such a helper already?

regards
Stefan Schmidt
