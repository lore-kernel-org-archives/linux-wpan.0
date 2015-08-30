Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:32935 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbbH3Vth (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sun, 30 Aug 2015 17:49:37 -0400
Subject: Re: [RFCv2 bluetooth-next 03/16] ieee802154: 6lowpan: remove check on
 null
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
 <1440089265-23366-4-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E37A6E.4010603@osg.samsung.com>
Date: Sun, 30 Aug 2015 23:49:34 +0200
MIME-Version: 1.0
In-Reply-To: <1440089265-23366-4-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 20/08/15 18:47, Alexander Aring wrote:
> This patch removes one check on null which should be already done by
> checking before for ARPHRD_IEEE802154. All ARPHRD_IEEE802154 and
> ARPHRD_IEEE802154_MONITOR should have wdev->ieee802154_ptr, where
> ARPHRD_IEEE802154 is currently a node interface only.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> index 8e9da1d..6607bb4 100644
> --- a/net/ieee802154/6lowpan/core.c
> +++ b/net/ieee802154/6lowpan/core.c
> @@ -214,7 +214,7 @@ static int lowpan_device_event(struct notifier_block *unused,
>   		 * also delete possible lowpan interfaces which belongs
>   		 * to the wpan interface.
>   		 */
> -		if (wdev->ieee802154_ptr && wdev->ieee802154_ptr->lowpan_dev)
> +		if (wdev->ieee802154_ptr->lowpan_dev)
>   			lowpan_dellink(wdev->ieee802154_ptr->lowpan_dev, NULL);
>   		break;
>   	default:

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
