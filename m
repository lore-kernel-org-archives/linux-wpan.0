Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35109 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbbDTSuM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Apr 2015 14:50:12 -0400
Received: by wgyo15 with SMTP id o15so189476250wgy.2
        for <linux-wpan@vger.kernel.org>; Mon, 20 Apr 2015 11:50:11 -0700 (PDT)
Date: Mon, 20 Apr 2015 20:50:08 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] ieee802154: Add trace events for rdev->ops
Message-ID: <20150420185005.GD707@omega>
References: <20150412120733.GA6181@bogon.m.sigxcpu.org>
 <5530F366.4030407@gmail.com>
 <20150420183555.GA5248@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150420183555.GA5248@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Mon, Apr 20, 2015 at 08:35:55PM +0200, Guido Günther wrote:
> On Fri, Apr 17, 2015 at 05:19:58PM +0530, Varka Bhadram wrote:
> > On 04/12/2015 05:37 PM, Guido Günther wrote:
> > > This is based on the rdev->ops tracing code from net/wireless/.
> > 
> > Instead of writing the above commit message its better to write
> > what exactly this code is for and how can we use this from
> > the user space (if possible with commands).
> 
> Adjusted in v2.
> 

or you can steal it from 14e8a3c47e808772a5ba8118ef1f9a8d604dbbe5
("cfg80211: add tracing to rdev-ops").

Or refer this commit in your commit message, but keeping style then
$ID ("$MSG").

- Alex
