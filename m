Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35676 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbbFDHab (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 03:30:31 -0400
Received: by wiga1 with SMTP id a1so38053193wig.0
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 00:30:30 -0700 (PDT)
Date: Thu, 4 Jun 2015 09:30:27 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] nl802154: export supported commands
Message-ID: <20150604073023.GB13133@omega>
References: <1433304841-12734-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433304841-12734-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Wed, Jun 03, 2015 at 09:44:01AM +0530, Varka Bhadram wrote:
> This patch will export the supported commands by the devices
> to the user. This is required because user should know supported
> commands by the IEEE-802.15.4 devices. Drivers that are there in
> the mainline are not supporting all the functionalities that the
> core is providing to us.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  include/net/nl802154.h    |    2 ++
>  net/ieee802154/nl802154.c |   36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> index 0badebd..6fc231e 100644
> --- a/include/net/nl802154.h
> +++ b/include/net/nl802154.h
> @@ -102,6 +102,8 @@ enum nl802154_attrs {
>  
>  	NL802154_ATTR_WPAN_PHY_CAPS,
>  
> +	NL802154_ATTR_SUPPORTED_COMMANDS,
> +
>  	/* add attributes here, update the policy in nl802154.c */
>  

for your v2, please also note the comment here "update the policy in
nl802154.c".

This means you need to add:

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 310a519..a6ae29d 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -228,6 +228,8 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
        [NL802154_ATTR_LBT_MODE] = { .type = NLA_U8, },
 
        [NL802154_ATTR_WPAN_PHY_CAPS] = { .type = NLA_NESTED },
+
+       [NL802154_ATTR_SUPPORTED_COMMANDS] = { .type = NLA_NESTED },
 };
 
 /* message building helper */


- Alex
