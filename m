Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:42357 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbeFGQWk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Jun 2018 12:22:40 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so12479717ioh.9
        for <linux-wpan@vger.kernel.org>; Thu, 07 Jun 2018 09:22:40 -0700 (PDT)
Date: Thu, 7 Jun 2018 12:22:33 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH net] net: ipv6: ip6_output: alloc skb with tailroom
Message-ID: <20180607162233.hepodtvuo7ictel2@x220t>
References: <20180605220404.6425-1-aring@mojatatu.com>
 <20180606.135339.2253125602143741999.davem@davemloft.net>
 <20180606180853.zimcpxbo3ejxum6g@x220t>
 <20180606.141125.1145874895676180399.davem@davemloft.net>
 <CAF=yD-L=OF+cBZ1zAeJYtYjR3Zb5jaYTZTk+o6uz+tcnT_-0+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF=yD-L=OF+cBZ1zAeJYtYjR3Zb5jaYTZTk+o6uz+tcnT_-0+Q@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Miller <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, david.palma@ntnu.no, rabinarayans0828@gmail.com, Jamal Hadi Salim <jhs@mojatatu.com>, stefan@osg.samsung.com, linux-wpan@vger.kernel.org, kernel@mojatatu.com, sd@queasysnail.net

Hi,

On Wed, Jun 06, 2018 at 04:26:19PM -0400, Willem de Bruijn wrote:
> On Wed, Jun 6, 2018 at 2:11 PM, David Miller <davem@davemloft.net> wrote:
> > From: Alexander Aring <aring@mojatatu.com>
> > Date: Wed, 6 Jun 2018 14:09:20 -0400
> >
> >> okay, then you want to have this patch for net-next? As an optimization?
> >>
> >> Of course, when it's open again.
> >
> > Like you, I have questions about where this adjustment is applied and
> > why.  So I'm not sure yet.
> >
> > For example, only IPV6 really takes it into consideration and as you
> > saw only really for the fragmentation path and not the normal output
> > path.
> >
> > This needs more consideration and investigation.
> 
> This is the unconditional skb_put in ieee802154_tx. In many cases
> there is some tailroom due to SKB_DATA_ALIGN in __alloc_skb,
> so it may take a specific case to not have even 2 bytes of tailroom
> available.

Yes it's in ieee802154_tx, but we need tailroom not just for checksum.
The bugreport is related to the two bytes of tailroom, because virtual
hardware doing checksum by software. The most real transceivers offload
this feature, so zero tailroom is needed.

I will of course add checks before adding L2 header for headroom and
tailroom in related subsystem code.

In IEEE 802.15.4 and secured enabled frames we need a MIC field at the
end of the frame. In worst case this can be 16 bytes.

I looked ethernet macsec feature and it seems they need to have a similar
reseved tailroom which is 16 bytes by default (max 32 bytes).

Maybe it's worth to take care for the tailroom in this path since it's
not just 2 bytes in some cases.

---

Meanwhile I think I found a bug in macsec, I cc Sabrina here:

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7de88b33d5b9..687323c0caf5 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -522,7 +522,7 @@ static bool macsec_validate_skb(struct sk_buff *skb, u16 icv_len)
 }
 
 #define MACSEC_NEEDED_HEADROOM (macsec_extra_len(true))
-#define MACSEC_NEEDED_TAILROOM MACSEC_STD_ICV_LEN
+#define MACSEC_NEEDED_TAILROOM MACSEC_MAX_ICV_LEN
 
 static void macsec_fill_iv(unsigned char *iv, sci_t sci, u32 pn)
 {

---

MACSEC_NEEDED_TAILROOM is the define to check and run skb_copy_expand()
and should use the ?worst case? or the the value (icv_len + ?extra_foo?)
is set as runtime generation on newlink.

I see that in macsec_newlink() following code:

if (data && data[IFLA_MACSEC_ICV_LEN])
	icv_len = nla_get_u8(data[IFLA_MACSEC_ICV_LEN]);

so the user can change it to (even a value above 32?, there is no check
for that). Anyway everything higher than MACSEC_STD_ICV_LEN could run
into a skb_over_panic().

- Alex
