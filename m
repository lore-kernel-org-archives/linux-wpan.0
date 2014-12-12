Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:54601 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967919AbaLLOkt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 09:40:49 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so9287809wgg.1
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 06:40:48 -0800 (PST)
Date: Fri, 12 Dec 2014 15:40:45 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc 1/2] website: fix milestone table name
Message-ID: <20141212144042.GD381@omega>
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

Again me,

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

really, this was a fast hacking because I really hate to describe in my
mails how to setup a 6LoWPAN interface. :-)

Now I can send the link. Didn't thought about many things while creating
this website but everyone can send patches to add more stuff into the
website.

First, it's good to have such website. The rest will hopeful be better
by historical changes.

- Alex
