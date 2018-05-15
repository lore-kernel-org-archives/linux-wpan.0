Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38349 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbeEOGzn (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 15 May 2018 02:55:43 -0400
Date: Tue, 15 May 2018 08:55:40 +0200
From: Michal Kubecek <mkubecek@suse.cz>
Subject: Re: Kernel panic on kernel-3.10.0-693.21.1.el7 in ndisc.h
Message-ID: <20180515065540.qynmnuty7oteqvdk@unicorn.suse.cz>
References: <CAKyrCQUJWq8aOMskFkr3FJF3Kgt2mKz5tsMCYH7PKqNawybJnA@mail.gmail.com>
 <20180514154002.ehab2ss25a45l5p6@x220t>
 <CAKyrCQWbFuRuFmn42Oo9qcOmHxxvsF=8Zg2a6d6aGaY034xHXA@mail.gmail.com>
 <20180514140611.26eec64f@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514140611.26eec64f@xeon-e3>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Roman Makhov <roman.makhov@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Alexander Aring <aring@mojatatu.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

On Mon, May 14, 2018 at 02:06:11PM -0700, Stephen Hemminger wrote:
> On Mon, 14 May 2018 21:29:03 +0300 Roman Makhov <roman.makhov@gmail.com> wrote:
> > Thank you for the answer.
> > Unfortunately CentOS goes with these dinosaurs.
> > So we will try to debug the problem in the current one and try to
> > reproduce on the latest kernel.
> 
> If you are stuck in old kernels, please bug the CentOs maintainers not
> upstream developers.

Actually, it's not even the dinosaur. Kernels from RHEL (and therefore
CentOS) or SLES differ from the original mainline version they are based
on quite a lot. It's possible that this bug didn't really exist in the
old 3.10 and is related to one of the backports added to CentOS (or
rather RHEL in this case) kernel. People outside of the distribution
have little idea what was backported and why so unless the issue can be
reproduced with mainline kernel they cannot be expected to help.

Michal Kubecek
