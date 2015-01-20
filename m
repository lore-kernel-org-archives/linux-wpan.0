Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38864 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbATLcm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 06:32:42 -0500
Received: by mail-wi0-f180.google.com with SMTP id bs8so22359268wib.1
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 03:32:41 -0800 (PST)
Date: Tue, 20 Jan 2015 12:32:34 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 1/2] treewide: shorten commands
Message-ID: <20150120113231.GA3922@omega>
References: <1421750140-24760-1-git-send-email-alex.aring@gmail.com>
 <006b01d034a0$ff2e9900$fd8bcb00$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <006b01d034a0$ff2e9900$fd8bcb00$@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: linux-wpan@vger.kernel.org

On Tue, Jan 20, 2015 at 11:05:26AM +0000, Stefan Schmidt wrote:
> Hello.
> 
> On 20/01/15 11:35, Alexander Aring wrote:
> >This patch shorten all commands. I had the idea to make a similarity
> >from PIB/MIB values according the 802.15.4 names convention but this is
> >bad for fast shell hacking. Mainly I remove the underscore and some
> >additional information which are not necessary like "_addr" in
> >"short_addr" and "extended_addr" and such things.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  src/info.c      | 10 +++++-----
> >  src/interface.c | 20 ++++++++++----------
> >  src/mac.c       | 10 +++++-----
> >  src/phy.c       |  6 +++---
> >  4 files changed, 23 insertions(+), 23 deletions(-)
> 
> Hmm, it feels like you are going overboard with shorting things here. Why is
> the reason behind it? Just less typing? Shell auto completion would handle
> this. :)
> 

it's just less typing and I notice that the original iw command doesn't
have an underscore in their commands.

The first time when I hacked it, then I just took the same naming
convention in kernel implementation which use the naming convention from
802.15.4 standard (without the beginning "MAC" and "PHY" keywords). Now
I am too lazy to always type pan_id short_addr, etc...

Do you like to implement some completion stuff which can be shipped out
optionally with the wpan-tools? :-)

> I mean it is up to you but with this you might break scripts that are
> already out there and I think the current  commands are quite fine. Cutting
> out the underscores makes some of these hard to read imho.
> 

mhhh, I am unsure also about this and just gave it a try if somebody
screams I would maybe reconsider this patch. :-)

- Alex
