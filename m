Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35710 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967493AbaLLOgQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 09:36:16 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so2678861wiw.13
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 06:36:15 -0800 (PST)
Date: Fri, 12 Dec 2014 15:36:12 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc 1/2] website: fix milestone table name
Message-ID: <20141212143609.GC381@omega>
References: <1418394106-12799-1-git-send-email-alex.aring@gmail.com>
 <548AFC69.9080106@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <548AFC69.9080106@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Dec 12, 2014 at 03:32:09PM +0100, Stefan Schmidt wrote:
> Hello.
> 
> On 12/12/14 15:21, Alexander Aring wrote:
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> >  website/index.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/website/index.txt b/website/index.txt
> > index a7ab4bb..5a3252b 100644
> > --- a/website/index.txt
> > +++ b/website/index.txt
> > @@ -114,7 +114,7 @@ Currently a rework of 802.15.4 subsystem is in progress.
> >  
> >  The rework will contains a new netlink API and a general handling about frame creation and parsing.
> >  
> > -.Supported 802.15.4 Hardware
> > +.Milestones
> >  [options="header"]
> >  |=======================================
> >  |Milestone        | Description | state
> 
> Both patches look good. I guess we don't do any Reviewed-By or Acked-By
> annotation here as you will directly apply them. :)
> 

yea, I can change the behaviour if you like I forget some "Reported-by: ...".
Isn't the linux kernel here. Only some small repo for website, logos,
etc..

I hope that's ok. Alternative would be I do some force push and fix that. :-)

-Alex
