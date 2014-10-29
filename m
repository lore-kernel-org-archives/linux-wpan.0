Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:41716 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbaJ2FjM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 01:39:12 -0400
Received: by mail-lb0-f179.google.com with SMTP id w7so1850551lbi.38
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 22:39:11 -0700 (PDT)
Date: Wed, 29 Oct 2014 06:39:08 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 01/17] mac802154: monitor: merge into
 iface implementation
Message-ID: <20141029053906.GB4709@omega>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
 <1414516892-4107-2-git-send-email-alex.aring@gmail.com>
 <5450617B.8030700@gmail.com>
 <545063CD.9030806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <545063CD.9030806@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Varka,

On Wed, Oct 29, 2014 at 09:19:33AM +0530, Varka Bhadram wrote:
> On 10/29/2014 09:09 AM, Varka Bhadram wrote:
> >On 10/28/2014 10:51 PM, Alexander Aring wrote:
> >>This patch removes the monitor implementation file and put all monitor
> >>stuff into iface file. It's now small enough to put all necessary
> >>handling into iface.
> >>
> >>Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >>---
> >>  net/mac802154/Makefile  |  2 +-
> >>  net/mac802154/iface.c   | 30 +++++++++++++++++++++++++
> >>  net/mac802154/monitor.c | 59
> >>-------------------------------------------------
> >>  3 files changed, 31 insertions(+), 60 deletions(-)
> >>  delete mode 100644 net/mac802154/monitor.c
> >>
> >Hi Alex,
> >
> >Doing nice work,changing the code view same as mac80211.
> >
> >But What ever you do in previous patches you are undoing, like moving some
> >of the
> >code to iface file from their to main file like that... Please correct me
> >if I am wrong.
> >
> >
> Good to have the cover-letter for all these changes...
> 

I tried to grab me one file and then doing all stuff which is in my
rework branch. First tx file then rx file, now with iface sending trivial
patches has ended here.

You are right cover-letters looks much ugly and patches contains too much changes
sometimes.

I want that all these changes are contain in the upcomming kernel release.
I will try to improve my cover-letter in the next series. For me wrtiting a
commit msg is more difficult than writing code and there will comming
much patches which will do many change.

The current code base for this branch is very bad and when we don't
doing anything here in this structual architecture then this branch will
die. For me it was already died when I cames mainline.

I can't simple send a patch which removes all 802.15.4 code and adding a
new implementation. We need to do this in small steps.

- Alex
