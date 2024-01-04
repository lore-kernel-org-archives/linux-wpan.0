Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC321374;
	Thu,  4 Jan 2024 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erXg30Ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A170FC433C7;
	Thu,  4 Jan 2024 22:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704407497;
	bh=gFzmqi8CpQHA/iuNbsd63pPTPSXCD08C0pOcPjX1vnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=erXg30YsNEpuxb63FciO6/JG22cBGLDOuxeJpQgB6Ll9NT9xKj6uKvJ64kdssRCX9
	 icBvCZzvFW2KcI6sAym8Jr2wPzu+YqkOlJ/e1cn4EX9M11F7DDPXlxzyqieexCqi3P
	 4J0fUyzyGWyi9ipT94B9+Bx6vD0fon2ziR+QjXg/3y7czV9/+VIHZ4CoOmDwMlqGmA
	 J8X2rFj70EO0Ot8P+FJyK5cHDp7+lppe8P2Ixx5mDzX4dX/9JVr0xdKqMQ+JXWrmoI
	 w3vLCO7f9o80d//HyVd8mT29xlyoRiNt46T4cRCclfoWTcWLqIZXJNKbpoy5f4+nIo
	 frydnO6kBGDFw==
Date: Thu, 4 Jan 2024 14:31:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>,
 netdev@vger.kernel.org, linux-wpan@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net-next 2023-12-20
Message-ID: <20240104143135.303e049f@kernel.org>
In-Reply-To: <20231222152017.729ee12b@xps-13>
References: <20231220095556.4d9cef91@xps-13>
	<20231222152017.729ee12b@xps-13>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 15:20:17 +0100 Miquel Raynal wrote:
> miquel.raynal@bootlin.com wrote on Wed, 20 Dec 2023 09:55:56 +0100:
> 
> > Hello Dave, Jakub, Paolo, Eric.
> > 
> > This is the ieee802154 pull-request for your *net-next* tree.  
> 
> I'm sorry for doing this but I saw the e-mail saying net-next would
> close tomorrow, I'd like to ensure you received this PR, as you
> are usually quite fast at merging them and the deadline approaches.

Sorry for the delay, I only caught up with enough email now :)

> It appears on patchwork, but the "netdev apply" worker failed, I've no
> idea why, rebasing on net-next does not show any issue.

That's because the pull URL is:

git@gitolite.kernel.org:pub ...

the bot doesn't have SSH access to kernel.org. IIRC you need to set 
the fetch URL in git remote for your repo to be over HTTPS. Only
leave push over SSH.

> https://patchwork.kernel.org/project/netdevbpf/patch/20231220095556.4d9cef91@xps-13/
> 
> Let me know if there is anything wrong.

Pulled now, thanks!
