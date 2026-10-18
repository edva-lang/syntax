import React, { useState } from 'react';

export function ProfileCard({ user, onFollow }) {
  const [following, setFollowing] = useState(false);

  const handleClick = () => {
    setFollowing(!following);
    if (onFollow) onFollow(user.id, !following);
  };

  return (
    <article className="profile-card">
      <header className="card-header">
        <img src={user.avatarUrl} alt={user.name} className="avatar" />
        <div className="user-info">
          <h3>{user.name}</h3>
          <span className="handle">@{user.username}</span>
        </div>
      </header>
      <p className="bio">{user.bio || 'No bio provided.'}</p>
      <footer>
        <button
          type="button"
          className={following ? 'btn-active' : 'btn-primary'}
          onClick={handleClick}
        >
          {following ? 'Following' : 'Follow'}
        </button>
      </footer>
    </article>
  );
}
