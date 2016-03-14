Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38890 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbcCNJaN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 14 Mar 2016 05:30:13 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so93777983wml.1
        for <linux-wpan@vger.kernel.org>; Mon, 14 Mar 2016 02:30:13 -0700 (PDT)
Date: Mon, 14 Mar 2016 10:30:06 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: =?utf-8?Q?PROBLEM=EF=BC=9Athere_exist?= =?utf-8?Q?s?= a wrong
 return value of function ieee802154_add_iface()
Message-ID: <20160314093001.GA4947@omega>
References: <485cdac3.48e1.1535e928b67.Coremail.rucsoftsec@163.com>
 <20160310090957.GA5020@omega>
 <56E1A330.5060304@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56E1A330.5060304@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Zhang Yan <rucsoftsec@163.com>, linux-wpan@vger.kernel.org

On Thu, Mar 10, 2016 at 05:39:12PM +0100, Stefan Schmidt wrote:
> Hello.
> 
> Missing a bit context here as the original message never made it to the
> list.
> 

linux-wpan was cc'ed inside the mail, but there was some html stuff
there... I don't know why it isn't arrived at linux-wpan.

Anyway...

There exists a bugzilla entry for that and John Linville said that I
should care about that, see [0].

> On 10/03/16 10:10, Alexander Aring wrote:
> >Hi,
> >
> >I think this is a good time to remove the deprecated netlink interface
> >for 802.15.4.
> >
> >Stefan please say your opinion here. There should be really nobody which
> >use this interface anymore.
> 
> My mind haven't really changed on this topic. I understand why you want it
> removed but given that the general rule of the kernel is to have backward
> compatibility we can't just remove it. Dropping the old netlink interface
> breaks userspace compatibility, even if it only is for deprecated tools like
> lowpan-tools, etc.
> 
> My take on it is that we live with it. Keeping it around but not extending
> it. Maybe add a warning to dmesg iwhen some application uses the old
> interface.
> 
> Is it more code cleanliness/maintenance or bug reports that urge you to get
> rid of it?

This is one of the smallest problem, I can live with "live with it". But
when I need to touch it because "nl802154" and "ieee802154" use the same
INTERNAL interface, e.g. llsec. I don't want to handle backwards
compatibility for that.

This complete handling with the damnd backwards compatibility for a
interface which is totally broken. (Yes I think [0] is one of the
smallest issues). We getting stucked in developing of 802.15.4 to
develop a better netlink interface (nl802154).

The old interface I would describe as:

- deprecated
- broken
- there exists no official userspace tool to handle everything, e.g.
  llsec, txpower, csma, etc...

I want to remove it otherwise the branch will die again, because stupid
handling a broken interface which nobody should use anymore.

My argument is:

Don't forget the 802.15.4 branch is still experimental, no maintainer
acked this commit [1]. For EXPERIMENTAL things you can be sure that the
UAPI interface will not be changed later and I would still say this
branch is EXPERIMENTAL.


I also have 3-4 things which we need to change inside the new interface
(nl802154), because the deprecated already handle it wrong and I simple
copy&pasted it... but it was wrong. Then handling of two UAPI's which
need to access the INTERNAL api (cfg802154) will be mostly impossible.

- Alex

[0] https://bugzilla.kernel.org/show_bug.cgi?id=114231
[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/net/ieee802154?id=f4671a90c418b5aae14b61a9fc9d79c629403ca0
