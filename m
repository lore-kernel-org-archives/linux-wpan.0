Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37050 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbbFRPcL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 11:32:11 -0400
Received: by wicgi11 with SMTP id gi11so17595071wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 18 Jun 2015 08:32:09 -0700 (PDT)
Date: Thu, 18 Jun 2015 17:32:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 802.15.4 security
Message-ID: <20150618153158.GA11086@omega>
References: <555DDC3E.6090203@xsilon.com>
 <20150528110026.70a44e0d@zoidberg>
 <55829983.3080608@xsilon.com>
 <20150618131330.6bc2f488@zoidberg>
 <20150618134013.2a035f46@zoidberg>
 <5582DD7B.6090907@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5582DD7B.6090907@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

On Thu, Jun 18, 2015 at 04:02:19PM +0100, Simon Vincent wrote:
> I have managed to get security working now in all modes.
> 
> I will submit a patch to fix the scatterlist bug.
> 
> The other problem I had was the IV was being generated incorrectly. This was
> because I had used the iwpan tools to set the mac address. This does not set
> the ieee802154_llsec_params.hwaddr[1] which is used for creating the IV.[2]
> 

Yea, I actually also know that using both netlink interfaces and only
the old one for security is broken, see [0]:

---

... I know currently there is some function
"mac802154_wpan_update_llsec" which makes the security layer to work,
because it's not called when setting short/panid anywhere else.

---

What I meant there was that if using nl802154 and updating address it
will not call mac802154_wpan_update_llsec. If you like you can set
patches for that.

> I am not sure the best way to fix this issue. Do we need to keep to keep a
> copy of the pan_id, hwaddr, coord_hwaddr, coord_shortaddr in the
> llsec_params? It seems like it could easily get missed and not updated if
> one of these parameters change.
> 

Well, I think there exists now better ways of course. But I would not
trust the implementation and we _maybe_ overlooked more than just the
missing calling of "mac802154_wpan_update_llsec".

We should go the way to support the crypto layer inside nl802154 and
then removing the old interface stuff.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg02098.html
