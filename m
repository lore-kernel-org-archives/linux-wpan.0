Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36577 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbcDXUFl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Apr 2016 16:05:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so16362705wmw.3
        for <linux-wpan@vger.kernel.org>; Sun, 24 Apr 2016 13:05:40 -0700 (PDT)
Date: Sun, 24 Apr 2016 22:05:30 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [riot-devel] RIOT+ULAs: no router entry
Message-ID: <20160424200528.GA27492@omega>
References: <B354489C-54BF-4CAF-8B41-04A946D83478@mlng.net>
 <20160422102833.GA5671@omega>
 <7BCB9BD8-C255-458C-83F6-0F7FE69F5C7F@mlng.net>
 <20160422122816.GA6364@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160422122816.GA6364@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: RIOT OS kernel developers <devel@riot-os.org>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Apr 22, 2016 at 02:28:16PM +0200, Alexander Aring wrote:
> On Fri, Apr 22, 2016 at 01:13:29PM +0200, smlng wrote:
...
> > 
> > @Alex as you joined the discussion: I also have a question regarding the Linux side. I currently use Raspbian with shipped Linux-Kernel 4.1.19. I observed that Linux still does NS for link-local address via the nodes scoped multicast address, instead of using 6lo 'shortcut' by extracting LL/MAC-address from the link-local IP. Is this fixed in some recent version?
> > 
> 
> There are currently pending patches for introducing neigh_ops, which is
> a callback strucuture for send/recv NS/NA. After this is mainline it
> should be easily to change this behaviour, or? What do you think?
> See [3] - function "lowpan_ndisc_send_ns".
> 

I think, I know what you mean. There is some NS with src as unspecified
addr "::" and dest is some "multicast node scope".

RFC 6775 says [0]:

An unspecified source address MUST NOT be used in NS messages.

Additional to the pending patches I added:

diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
index d088295..c6207cd 100644
--- a/net/6lowpan/ndisc.c
+++ b/net/6lowpan/ndisc.c
@@ -386,8 +386,11 @@ static void lowpan_ndisc_send_ns(struct net_device *dev,
                saddr = &addr_buf;
        }
 
+       /* RFC6775:
+        * An unspecified source address MUST NOT be used in NS messages.
+        */
        if (ipv6_addr_any(saddr))
-               inc_opt = false;
+               return;
        if (inc_opt) {
                optlen += ndisc_opt_addr_space(dev, dev->addr_len);
                optlen += lowpan_ndisc_802154_short_addr_space(dev);


This will not sending NS with "::" addresses as source address.

However, it's a little bit ugly we should prevent to calling this
callback when source address is "::".

This patch should be fine at first but can maybe optimized in future.

---

Also for processing NS the "::" seems to be different [1], "::" seems to
valid (ARO will be ignored than but we don't support it so it's default
ignored). :-)

- Alex

[0] https://tools.ietf.org/html/rfc6775#section-5.5.1
[1] https://tools.ietf.org/html/rfc6775#section-6.5
