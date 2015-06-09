Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38630 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773AbbFILut (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 9 Jun 2015 07:50:49 -0400
Message-ID: <5576D314.1040200@osg.samsung.com>
Date: Tue, 09 Jun 2015 13:50:44 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] ieee802154/cc2520: check for return values
 in cc2520_filter()
References: <1433841108-1122-1-git-send-email-stefan@osg.samsung.com> <5576B00C.6020003@gmail.com> <5576B71F.4030905@osg.samsung.com> <20150609100158.GB1402@omega>
In-Reply-To: <20150609100158.GB1402@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 09/06/15 12:02, Alexander Aring wrote:
> On Tue, Jun 09, 2015 at 11:51:27AM +0200, Stefan Schmidt wrote:
>> Well, imho its not a subsubsystem but rather a simple file. Also using
>> subsytem: file: looks quite alien to me. Anyway, matter of taste, nothing to
>> argue about. Fixed in v2.
>>
> sorry, I never see foo/bar: things at begin of the subject. I see David
> Miller on netdev which only mentioned that the usually way is
> "subsystem:", when somebody complete forgets to add this. For me it doesn't matter
> if somebody will more specify it like "subsystem: drivers: file:" or
> "subsystem: file: ..." that's everything fine, but don making a '/' somewhere.

I see both forms used regularly when looking through git log. Anyway, if 
the preferred form is subsystem: drivers: I'm ok with that. Not making 
any fuzz about it. Maybe I'm just used to the other notation. :)

regards
Stefan Schmidt
