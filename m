Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33577 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbbELKdJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 May 2015 06:33:09 -0400
Received: by wief7 with SMTP id f7so108427929wie.0
        for <linux-wpan@vger.kernel.org>; Tue, 12 May 2015 03:33:08 -0700 (PDT)
Date: Tue, 12 May 2015 12:33:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Ieee802154 socket problem with SIOCGIFADDR
Message-ID: <20150512103301.GD733@omega>
References: <554E1C92.7040306@sssup.it>
 <20150509164227.GA694@omega>
 <5550DC2D.5060909@sssup.it>
 <20150511175141.GA7965@omega>
 <5551BAB9.9000101@sssup.it>
 <20150512083917.GC733@omega>
 <5551CC74.60702@sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5551CC74.60702@sssup.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

On Tue, May 12, 2015 at 11:48:36AM +0200, Matteo Petracca wrote:
> You were right, I did not remove the Assertion.
> 
> Now the patch is all there and the modules are
> updated.
> 
> What happens now is a strange behaviour, booting
> the system I just turn on the wpan interface putting
> as panid 0xaaaa:
> 
> ifconfig wpan0 up
> 
> the device starts to read from the network, and this is
> what I have in output with dmesg is:
> 
> [  131.445285] ieee802154: bad frame received (type = 3)
> [  133.777933] ieee802154: bad frame received (type = 3)
> [  136.110635] ieee802154: bad frame received (type = 3)
> [  148.318471] ieee802154: bad frame received (type = 3)
> [  150.651288] ieee802154: bad frame received (type = 3)
> [  152.984910] ieee802154: bad frame received (type = 3)
> [  165.195277] ieee802154: bad frame received (type = 3)
> [  167.527936] ieee802154: bad frame received (type = 3)
> [  169.860422] ieee802154: bad frame received (type = 3)
> [  182.071635] ieee802154: bad frame received (type = 3)
> [  184.406857] ieee802154: bad frame received (type = 3)
> [  186.739487] ieee802154: bad frame received (type = 3)
> [  198.947054] ieee802154: bad frame received (type = 3)
> [  201.279710] ieee802154: bad frame received (type = 3)
> [  203.612262] ieee802154: bad frame received (type = 3)
> [  215.819843] ieee802154: bad frame received (type = 3)
> [  218.155852] ieee802154: bad frame received (type = 3)
> [  220.488465] ieee802154: bad frame received (type = 3)
> 
> Moreover SIOCGIFADDR still does not work.
> 

This is a behaviour because we have lack of support to parse mac_cmd
frames [0]. And I see now I already told you that! [1]

The current parsing mechanism is very dataframes specfic there is an 
draft for reworking this frame parsing style and do it like mac80211
(which have a lot of more frametypes than 802.15.4). See [2]:
"new frame parsing style in mac802154 and ieee802154 based on mac80211
frame parsing design. Draft is mac802154 rx and 6LoWPAN. Crypto need to
be done at first, otherwise I can’t test it."

Nevertheless it needs time to supporting it, you could simple add a case
that the frame is delivered to userspace, but then this frame could not
valid 802.15.4 frametype and you need to check that again in userspace.

I also noticed that the raw socket don't put the mac header into payload
(which should it do), see [3] (that's something which already told you).

and yes, the 802.15.4 sockets needs a complete rework/cleanup. This is
an opentask section at [4], we should orient us at bluetooth socket
code.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac802154/rx.c#n104
[1] http://www.spinics.net/lists/linux-wpan/msg01623.html
[2] http://wpan.cakelab.org/
[3] http://www.spinics.net/lists/linux-wpan/msg01623.html
[4] http://wpan.cakelab.org/

