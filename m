Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37898 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbbFIKCF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 06:02:05 -0400
Received: by wibdq8 with SMTP id dq8so10766504wib.1
        for <linux-wpan@vger.kernel.org>; Tue, 09 Jun 2015 03:02:04 -0700 (PDT)
Date: Tue, 9 Jun 2015 12:02:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] ieee802154/cc2520: check for return
 values in cc2520_filter()
Message-ID: <20150609100158.GB1402@omega>
References: <1433841108-1122-1-git-send-email-stefan@osg.samsung.com>
 <5576B00C.6020003@gmail.com>
 <5576B71F.4030905@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5576B71F.4030905@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Tue, Jun 09, 2015 at 11:51:27AM +0200, Stefan Schmidt wrote:
> 
> Well, imho its not a subsubsystem but rather a simple file. Also using
> subsytem: file: looks quite alien to me. Anyway, matter of taste, nothing to
> argue about. Fixed in v2.
> 

sorry, I never see foo/bar: things at begin of the subject. I see David
Miller on netdev which only mentioned that the usually way is
"subsystem:", when somebody complete forgets to add this. For me it doesn't matter
if somebody will more specify it like "subsystem: drivers: file:" or
"subsystem: file: ..." that's everything fine, but don making a '/' somewhere.

But I see also  people which tags "6lowpan:" only and then it touched
net/ieee802154/6lowpan only. That's confusing, it should be then
"ieee802154: 6lowpan:". If it touched the net/6lowpan it should be
"6lowpan:" only.

I think I need to make some harder rules to check on this.

- Alex
