Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10707280338;
	Fri, 24 Jul 2026 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886246; cv=none; b=N8ZoN1IjgtSM0tlOzJ3opKhePAmg+Gs5AcXxoqZDNh54Wh2DtcrAmhxTN3N3w1kHwyy6Ka6p+/Fi+jw0rPK88rVsYE0bfg1vQxjqRIFNfiXJ1hz1Rz75DZ4nVGOy2xnHShQ4mFuve0HXDonVRuisCg5caBS7EmYHw7Oea/gRrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886246; c=relaxed/simple;
	bh=ENZq1sRoe+bg+jCqkROPH1u79hpXiEp66QQ0m1CkCyI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFSAbE1egVEuY5ouD8HbtV/axsrS3yAvljWzTiZql+9dR+Rp9AF5v/bE1dCPUs4mBBoFEzu+rVUiW2waex5wlmrMnB7RfJUAQOc/P2HyIa1bstq9cwRGOzq/TRtTlzTBoFSs9M5fPSfS4Fl6WKrxkd2WbsssCKQOfNpKAiFgtao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Aw53nk63; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Aw53nk63"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PEHSgmAsbVIIBLbgPXBTQPvZ8uMJSPGaCWButB41j+U=; b=Aw53nk63unEaChdxudR9lZyLUe
	Fd3Wi8o9x25JXNWg6rTW343w0QqGt3Mk6BcrfSfvkmkOP+WxiZ0OqhPPlfdeO02vyQDkkVXKHDpAZ
	j6JazJFMgKJTsyRHHTpgBJL4y2osFasWb2MNTJQPNbeAyZdfKcph3iexi/f4703rYyLn/dOLrWpIN
	nXsDcoLY3g619PFNCTQ9h1WcYxN1nB5TfsYRy7J1ZOLaEcXf4ig1XBlSqzwQE0yfXL7haHIaF3kxk
	WU9OUk9ElnWKNgFcHhRERzAcM477ZK4UokW8ix4nteU8+m5//yKLGMFuUZYNfYbB6JzhectiGRG9f
	ms2lhn6w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnCRY-004T1S-1G;
	Fri, 24 Jul 2026 09:43:48 +0000
Date: Fri, 24 Jul 2026 02:43:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Joe Damato <joe@dama.to>, sdf@fomichev.me, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/7] ieee802154: convert dgram getsockopt to
 sockopt_t
Message-ID: <amMvRiiPI7BY3Bqw@gmail.com>
References: <20260720-getsockopt_phase4-v2-0-8a08fcfa0d72@debian.org>
 <20260720-getsockopt_phase4-v2-3-8a08fcfa0d72@debian.org>
 <amDIUv4Sa/i7MfEq@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDIUv4Sa/i7MfEq@devvm20253.cco0.facebook.com>
X-Debian-User: leitao

On Wed, Jul 22, 2026 at 06:40:34AM -0700, Joe Damato wrote:
> On Mon, Jul 20, 2026 at 09:17:44AM -0700, Breno Leitao wrote:
> > Continue converting the proto-layer getsockopt callbacks to the sockopt_t
> > interface, splitting dgram_getsockopt() into a do_dgram_getsockopt() helper
> > that takes a sockopt_t.
> > 
> > No functional change.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/ieee802154/socket.c | 38 ++++++++++++++++++++++++++------------
> >  1 file changed, 26 insertions(+), 12 deletions(-)
> > 
> > diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> > index 85dce296d7513..763f63e48afe4 100644
> > --- a/net/ieee802154/socket.c
> > +++ b/net/ieee802154/socket.c
> > @@ -831,20 +831,12 @@ static int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb)
> >  	return ret;
> >  }
> >  
> > -static int dgram_getsockopt(struct sock *sk, int level, int optname,
> > -			    char __user *optval, int __user *optlen)
> > +static int do_dgram_getsockopt(struct sock *sk, int optname, sockopt_t *opt)
> >  {
> >  	struct dgram_sock *ro = dgram_sk(sk);
> > -
> >  	int val, len;
> >  
> > -	if (level != SOL_IEEE802154)
> > -		return -EOPNOTSUPP;
> > -
> > -	if (get_user(len, optlen))
> > -		return -EFAULT;
> > -
> > -	len = min_t(unsigned int, len, sizeof(int));
> > +	len = min_t(unsigned int, opt->optlen, sizeof(int));
> 
> Does the same min() feedback David gave on the last revision apply here as
> well?

yes, but it should be umin() and not min() as suggeted by David.

min() is not good at comparing different types (len as int, and sizeof
as unsigned int) and fails to compile with sign mismatch.

  BUILD_BUG_ON_MSG(!__types_ok(ux, uy), "min(...) signedness error");

On the other side, umin() is the rigth approach, given we know that len
is positive (sockopt_init_user() rejects negative optlen), and it It
avoids narrowing the size_t, which is makes no difference in practice,
given this is getsockopt operations, but, it is still more correct.

That said, I will update this to umin() and respin.

Thanks for the review and catching this up.
--breno

--
pw-bot: cr
