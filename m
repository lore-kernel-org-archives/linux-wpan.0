Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:60572 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbaKZFCP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 26 Nov 2014 00:02:15 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next] mac802154: remove unnecessary if statement
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416913483-19314-1-git-send-email-varkab@cdac.in>
Date: Wed, 26 Nov 2014 14:02:07 +0900
Content-Transfer-Encoding: 8BIT
Message-Id: <194E43DA-FC22-4AB0-8D61-C7F146DDEF03@holtmann.org>
References: <1416913483-19314-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hi Varka,

> Removes unnecessary if statement check for net device. Error check performed
> after alloc_netdev().
> 
> 	ndev = alloc_netdev(sizeof(*sdata) + local->hw.vif_data_size, name,
> 			    NET_NAME_UNKNOWN, ieee802154_if_setup);
>        if (!ndev)
>                return ERR_PTR(-ENOMEM);
> 	..
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
> net/mac802154/iface.c |    8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

