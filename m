Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:43576 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbcLBNyz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Dec 2016 08:54:55 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [GIT pull] pull request for wpan-next 2016-11-30
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1480514605-30926-1-git-send-email-stefan@osg.samsung.com>
Date: Fri, 2 Dec 2016 14:54:52 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <A86C4DDF-1D93-4EAC-9686-F611B156846C@holtmann.org>
References: <1480514605-30926-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hi Stefan,

> find below a pull request for all pending patches we have sitting on the linux-wpan mailing list.
> I pulled them together to have a better chance to still get them into bluetooth-next and net-next
> before the merge window opens. If you have a problem taking them or are not planning to do another
> pull request towards net-next please let me know so I can try my luck with Dave directly. Missing
> the window for things that are on the list for a while would be a pity.
> 
> The changes itself are non intrusive and sometimes even trivial. There is also no code touching
> bluetooth or the shared 6lowpan subsystems. We have a fix for a potential NULL deref in the
> ieee802154 netlink code, a fix for the ED values of the at86rf2xx driver, some doc update and the
> addition of myself as the co-maintainer for ieee802154 to help Alex.
> 
> If you are uncomfortable to pull form the GitHub repo the patches are also coming as a re-posted
> patchset in reply to this pull request.
> 
> regards
> Stefan Schmidt
> 
> The following changes since commit 1ae6d00ad05730bca283dc09e7a9c162c2f22b01:
> 
>  Bluetooth: hci_qca: Use setup_timer Kernel API instead of init_timer (2016-11-27 07:41:05 +0100)
> 
> are available in the git repository at:
> 
>  https://github.com/linux-wpan/linux-wpan-next.git for-next

changes have been pulled into bluetooth-next tree.

Regards

Marcel

