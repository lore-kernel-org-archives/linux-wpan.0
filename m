Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:59305 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbaJAIQ7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Oct 2014 04:16:59 -0400
Received: by mail-wg0-f46.google.com with SMTP id k14so464116wgh.17
        for <linux-wpan@vger.kernel.org>; Wed, 01 Oct 2014 01:16:58 -0700 (PDT)
Date: Wed, 1 Oct 2014 10:16:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Problems with fakeserial
Message-ID: <20141001081655.GB25131@omega>
References: <542ACF52.3030807@xsilon.com>
 <20141001003814.GB1007@omega>
 <542BB5B1.5010705@xsilon.com>
 <20141001081102.GA25131@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141001081102.GA25131@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Wed, Oct 01, 2014 at 10:11:02AM +0200, Alexander Aring wrote:
> Hi Martin,
> 
> On Wed, Oct 01, 2014 at 09:05:05AM +0100, Martin Townsend wrote:
> > Hi Alex,
> > 
> > Do you know where I can find the serial driver module?
> > 
> 
> yes, the last known version for me is this what Tony Chenau did. [0]
> 
s/Chenau/Cheneau/

and please don't forget the fix for error handling at lowpan_rcv. When
do you want to send a new patch version for that?

- Alex
