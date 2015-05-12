Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35015 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbbELLxG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 May 2015 07:53:06 -0400
Received: by widdi4 with SMTP id di4so149470557wid.0
        for <linux-wpan@vger.kernel.org>; Tue, 12 May 2015 04:53:05 -0700 (PDT)
Date: Tue, 12 May 2015 13:53:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 3/3] mac802154: remove mib lock
Message-ID: <20150512115258.GF733@omega>
References: <1431290456-25524-1-git-send-email-alex.aring@gmail.com>
 <1431290456-25524-4-git-send-email-alex.aring@gmail.com>
 <20150512075018.GB733@omega>
 <20150512130615.3f8409f6@zoidberg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150512130615.3f8409f6@zoidberg>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi,

...
> > 
> > Introduce a percpu counter for the sequence numbers, incrementation of
> > this counter is an atomic operation then and we are sure that we don't
> > sending the same sequence number when calling this function at the
> > same time.
> 
> With this, two threads running on the same interface can send different
> packets with the same sequence number back to back. Maybe better make
> it atomic instead of percpu instead to avoid that?
> 

Yes you are right, that's not correct. Because per_cpu is a local
variable what's the name said _per_ _cpu_. For this kind of very global
mib value which needs to be incremented after each transmit a atomic_t
should be correct here and that's also what the comment said.

Damn, why I thought that a percpu variable should be correct here.

- Alex
