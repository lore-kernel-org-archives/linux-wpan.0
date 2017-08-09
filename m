Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50848
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752472AbdHILRP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Aug 2017 07:17:15 -0400
Subject: Re: [PATCH v0 2/2] mac802154: replace hardcoded value with macro
References: <1502126560-24462-1-git-send-email-dvnp@cesar.org.br>
 <1502126560-24462-2-git-send-email-dvnp@cesar.org.br>
 <eb269ae9-90c8-7363-662e-ac2bb20cbc42@osg.samsung.com>
 <CAC9NHkm=SknMqkY8MuaOuJsnnBWauFAzU_cjYttMxRh6N0MQuA@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <c6138293-69d9-ec39-b426-5332380edaf3@osg.samsung.com>
Date: Wed, 9 Aug 2017 13:17:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAC9NHkm=SknMqkY8MuaOuJsnnBWauFAzU_cjYttMxRh6N0MQuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Di=c3=b3genes_Vila_Nova_Pereira?= <dvnp@cesar.org.br>
Cc: linux-wpan@vger.kernel.org

Hello.

On 08/09/2017 01:07 PM, Diógenes Vila Nova Pereira wrote:
> Hi Stefan,
> 
> I can fix this same patch file and send it again ?

Yes, please do so.

regards
Stefan Schmidt

> Rgds
> 
> *Saúde e Paz !
> []'s
> Diogenes Pereira*
> Senior Embedded Software Engineer
> 
> *E-mail: * dvnp@cesar.org.br <mailto:dvnp@cesar.org.br>
> *Celular:* +55 81 98895 0809
> *Comercial:* +55 81 3419 6706
> 
> <http://www.cesar.org.br/>
> Antes de imprimir, pense em sua responsabilidade e compromisso com o 
> MEIO AMBIENTE.
> 
> NOTICE: This transmittal and/or attachments is confidential. If you are 
> not the intended recipient, you are hereby notified that you have 
> received this transmittal in error and that any review, dissemination, 
> distribution or copying of this message is strictly prohibited. If you 
> have received this message in error, please notify us immediately and 
> immediately delete this message and all its attachments. Thank you.
> 
> On Wed, Aug 9, 2017 at 7:47 AM, Stefan Schmidt <stefan@osg.samsung.com 
> <mailto:stefan@osg.samsung.com>> wrote:
> 
>     Hello.
> 
>     On 08/07/2017 07:22 PM, Diogenes Pereira wrote:
> 
>         Use IEEE802154_SCF_SECLEVEL_NONE macro defined at ieee802154.h file.
> 
>         Signed-off-by: Diogenes Pereira <dvnp@cesar.org.br
>         <mailto:dvnp@cesar.org.br>>
>         ---
>            net/mac802154/llsec.c | 3 ++-
>            1 file changed, 2 insertions(+), 1 deletion(-)
> 
>         diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
>         index 3c8ae3f..f51093e 100644
>         --- a/net/mac802154/llsec.c
>         +++ b/net/mac802154/llsec.c
>         @@ -718,7 +718,8 @@ int mac802154_llsec_encrypt(struct
>         mac802154_llsec *sec, struct sk_buff *skb)
>                  if (hlen < 0 || hdr.fc.type != IEEE802154_FC_TYPE_DATA)
>                          return -EINVAL;
>            -     if (!hdr.fc.security_enabled || hdr.sec.level == 0) {
>         +       if (!hdr.fc.security_enabled ||
>         +               hdr.sec.level == IEEE802154_SCF_SECLEVEL_NONE) {
> 
> 
>     Please align the start of the new line with the open parenthesis.
> 
>     With this change you can add my
> 
>     Acked-by: Stefan Schmidt <stefan@osg.samsung.com
>     <mailto:stefan@osg.samsung.com>>
> 
>     regards
>     Stefan Schmidt
> 
> 
