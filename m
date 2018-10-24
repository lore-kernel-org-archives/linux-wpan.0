Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40140 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYAby (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Oct 2018 20:31:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id z9-v6so6145947qto.7
        for <linux-wpan@vger.kernel.org>; Wed, 24 Oct 2018 09:03:14 -0700 (PDT)
Date: Wed, 24 Oct 2018 12:03:09 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH wpan-tools] wpan-hwsim: fix long option argument option
 for dot
Message-ID: <20181024160309.n3fuxn7qruhkgsrk@x220t>
References: <20181016153821.10331-1-aring@mojatatu.com>
 <f802d6d7-7067-e787-1eaa-eb439ab9af9e@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f802d6d7-7067-e787-1eaa-eb439ab9af9e@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org

Hi,

On Wed, Oct 24, 2018 at 05:28:59PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 16/10/2018 17:38, Alexander Aring wrote:
> > This patch fixes the long option argument option to no argument. The dot
> > argument doesn't require any postponed argument.
> > 
> > Signed-off-by: Alexander Aring <aring@mojatatu.com>
> > ---
> >  wpan-hwsim/wpan-hwsim.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/wpan-hwsim/wpan-hwsim.c b/wpan-hwsim/wpan-hwsim.c
> > index dcddb09..3e54348 100644
> > --- a/wpan-hwsim/wpan-hwsim.c
> > +++ b/wpan-hwsim/wpan-hwsim.c
> > @@ -393,7 +393,7 @@ int main(int argc, const char *argv[])
> >  		static struct option long_options[] = {
> >  			{"help",	no_argument,		0,	'h' },
> >  			{"version",	no_argument,		0,	'v' },
> > -			{"dot",		required_argument,	0,	'd' },
> > +			{"dot",		no_argument,		0,	'd' },
> >  			{"ignore",	required_argument,	0,	'i' },
> >  			{0,				0,	0,	0 }
> >  		};
> > 
> 
> Applied to wpan-tools repo.
> 
> Is there anythign else left you wanted to have in before we look into a
> new release?
> 

no I might figure them out when debian backports ship 4.19 kernel.

- Alex
