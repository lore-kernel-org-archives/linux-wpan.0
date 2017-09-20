Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:46922
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751768AbdITMbV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Sep 2017 08:31:21 -0400
Subject: Re: [PATCH v1] mac802154: replace hardcoded value with macro
References: <1502126560-24462-2-git-send-email-dvnp@cesar.org.br>
 <1502295564-20178-1-git-send-email-dvnp@cesar.org.br>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <b938b461-10b0-02a7-d055-e4106512f2b3@osg.samsung.com>
Date: Wed, 20 Sep 2017 14:31:17 +0200
MIME-Version: 1.0
In-Reply-To: <1502295564-20178-1-git-send-email-dvnp@cesar.org.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Diogenes Pereira <dvnp@cesar.org.br>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com

Hello.

On 08/09/2017 06:19 PM, Diogenes Pereira wrote:
> Use IEEE802154_SCF_SECLEVEL_NONE macro defined at ieee802154.h file.
> 
> Signed-off-by: Diogenes Pereira <dvnp@cesar.org.br>
> Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  net/mac802154/llsec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
> index 1e1c9b2..edec2f9 100644
> --- a/net/mac802154/llsec.c
> +++ b/net/mac802154/llsec.c
> @@ -713,7 +713,8 @@ int mac802154_llsec_encrypt(struct mac802154_llsec *sec, struct sk_buff *skb)
>  	if (hlen < 0 || hdr.fc.type != IEEE802154_FC_TYPE_DATA)
>  		return -EINVAL;
>  
> -	if (!hdr.fc.security_enabled || hdr.sec.level == 0) {
> +	if (!hdr.fc.security_enabled ||
> +	    (hdr.sec.level == IEEE802154_SCF_SECLEVEL_NONE)) {
>  		skb_push(skb, hlen);
>  		return 0;
>  	}
> 

Thanks! This patch has been applied to the wpan-next tree and will be part of the next pull request.

regards
Stefan Schmidt
