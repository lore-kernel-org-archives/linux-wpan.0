Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50751
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751890AbdHIKsE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Aug 2017 06:48:04 -0400
Subject: Re: [PATCH v0 2/2] mac802154: replace hardcoded value with macro
References: <1502126560-24462-1-git-send-email-dvnp@cesar.org.br>
 <1502126560-24462-2-git-send-email-dvnp@cesar.org.br>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <eb269ae9-90c8-7363-662e-ac2bb20cbc42@osg.samsung.com>
Date: Wed, 9 Aug 2017 12:47:59 +0200
MIME-Version: 1.0
In-Reply-To: <1502126560-24462-2-git-send-email-dvnp@cesar.org.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Diogenes Pereira <dvnp@cesar.org.br>, linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de

Hello.

On 08/07/2017 07:22 PM, Diogenes Pereira wrote:
> Use IEEE802154_SCF_SECLEVEL_NONE macro defined at ieee802154.h file.
> 
> Signed-off-by: Diogenes Pereira <dvnp@cesar.org.br>
> ---
>   net/mac802154/llsec.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
> index 3c8ae3f..f51093e 100644
> --- a/net/mac802154/llsec.c
> +++ b/net/mac802154/llsec.c
> @@ -718,7 +718,8 @@ int mac802154_llsec_encrypt(struct mac802154_llsec *sec, struct sk_buff *skb)
>   	if (hlen < 0 || hdr.fc.type != IEEE802154_FC_TYPE_DATA)
>   		return -EINVAL;
>   
> -	if (!hdr.fc.security_enabled || hdr.sec.level == 0) {
> +	if (!hdr.fc.security_enabled ||
> +		hdr.sec.level == IEEE802154_SCF_SECLEVEL_NONE) {

Please align the start of the new line with the open parenthesis.

With this change you can add my

Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
