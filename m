Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:60562 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbaJTHZa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Oct 2014 03:25:30 -0400
Date: Mon, 20 Oct 2014 09:25:23 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 0/5] Move skb delivery out of IPHC.
Message-ID: <20141020072520.GA5404@omega>
References: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1413616153-7562-1-git-send-email-mtownsend1973@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Martin,

I did a fast quick test and it's still working. I see now the conversion
from to errno, but you didn't change/fix the behaviour with kfree_skb. I
am pretty sure this is still broken with and without your patch.

I know you want to make smaller patches but can you please add the
conversion simple to this patch series? What I see now is the change
from if (ret != NET_RX_FOO) to errno. This change the behaviour of
current somewhat working state. What I mean, it's okay to change that
but please in a serie which contains also fixes for the kfree_skb thing.

Important:
All patches should be compileable after each patch keyword "bisectable"
otherwise people can't use "git bisect".

But in your case this should be fine.

It should also not broken between them, but this is a bigger issue.
Smaller patches for better review are welcome.


To your patch series:

- You missed a tag "6lowpan:", "ieee802154: 6lowpan:" or "bluetooth: 6lowpan:"
  Use the tag which best fit to your patch. Also add a tag to the
  cover-letter "6lowpan:"

- Please "fixup" patch 4/5 with patch 1/5. "fixup" is some git language,
  what I mean is just include the remove of "skb_delivery_cb skb_deliver", when
  remove the use of that. Now you have two patches for this in your git
  history, with "git rebase -i" and a fixup you don't need to touch the
  patch again. Just for information, maybe you don't know that. Fast
  googleing results [0] tutorial.

- Sometimes you add a dot in commit message, sometimes not. Please start
  the commit msg in lower case and remove the dot.


- Alex

[0] http://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html
