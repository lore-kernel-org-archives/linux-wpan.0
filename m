Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:60713 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbaIXGy1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 02:54:27 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so2453241wgg.7
        for <linux-wpan@vger.kernel.org>; Tue, 23 Sep 2014 23:54:26 -0700 (PDT)
Date: Wed, 24 Sep 2014 08:54:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-next v3 0/3] cleanup for mrf24j40
Message-ID: <20140924065419.GA24434@omega>
References: <1411124237-16919-1-git-send-email-varkab@cdac.in>
 <5420DF1B.1000302@signal11.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5420DF1B.1000302@signal11.us>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alan Ott <alan@signal11.us>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Mon, Sep 22, 2014 at 10:46:51PM -0400, Alan Ott wrote:
> On 09/19/2014 06:57 AM, Varka Bhadram wrote:
> >changes since v2:
> >- generated patches based on wpan-next
> >
> >changes since v1:
> >- changes in commit messages and descriptions suggested by Alan Ott
> >
> >Varka Bhadram (3):
> >   mrf24j40: fix Missing a blank line after declarations
> >   mrf24j40: remove unnecessary return statement
> >   mrf24j40: use pr_* / dev_* instead of printk()
> >
> >  drivers/net/ieee802154/mrf24j40.c |   19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >
> 
> Acked-by: Alan Ott <alan@signal11.us>
> 

Patches applied to wpan-next/testing branch. Note I catch all patches to
the testing branch and when these are applied to bluetooth then I rebase
the master branch again to the bluetooth master branch.

After that you have these patches are inside of wpan-next master branch.

- Alex
