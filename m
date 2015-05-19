Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:42353 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbbESWFD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 18:05:03 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/8] Documentation/networking/ieee802154.txt: fix various inaccuracies.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150519195000.GN11014@wantstofly.org>
Date: Wed, 20 May 2015 00:05:02 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <148935A5-4809-4999-9C45-445A9768A7DC@holtmann.org>
References: <cover.1432064518.git.buytenh@wantstofly.org> <20150519195000.GN11014@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

> * Update the linux-zigbee git:// repository URL.
> 
> * The IEEE 802.15.4 MLME based netlink operations are documented
>  in include/linux/nl802154.h, not in include/net/nl802154.h.
> 
> * The hardmac example driver 'fakehard' was removed some time ago.
> 
> * The IEEE 802.15.4 device drivers live in drivers/net/ieee802154/,
>  not in drivers/ieee802154/.
> 
> * The IEEE 802.15.4 MTU is 127 bytes, not 128 bytes.
> 
> * Some of the 6LoWPAN code lives in net/6lowpan/.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> ---
> Documentation/networking/ieee802154.txt | 25 ++++++++++++-------------
> 1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
> index 22bbc72..ed08768 100644
> --- a/Documentation/networking/ieee802154.txt
> +++ b/Documentation/networking/ieee802154.txt
> @@ -30,8 +30,8 @@ int sd = socket(PF_IEEE802154, SOCK_DGRAM, 0);
> 
> The address family, socket addresses etc. are defined in the
> include/net/af_ieee802154.h header or in the special header
> -in our userspace package (see either linux-zigbee sourceforge download page
> -or git tree at git://linux-zigbee.git.sourceforge.net/gitroot/linux-zigbee).
> +in our userspace package (see either linux-zigbee sourceforge download
> +page or git tree at git://git.code.sf.net/p/linux-zigbee/linux-zigbee).

I assumed Alex created a linux-wpan userspace repository. I think if we update the text here, we should reference that one.

Regards

Marcel

